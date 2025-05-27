class DailySyncDifference < ApplicationRecord
  belongs_to :investigation

  def self.create_from_changed_investigation(date, investigation)
    differences = investigation.changes.dup

    # Do nothing if the only change is a 1-hour difference in the event_date.
    # For some reason, the NTSB servers seem to oscillate back and forth between
    # values of the event_date.
    if (before, after = differences["event_date"]) && (after - before).abs == 1.hour
      differences.delete("event_date")

      before_json, after_json = differences["contents_raw"]
      if before_json.without("cm_eventDate") == after_json.without("cm_eventDate")
        differences.delete("contents_raw")
      end
    end

    if differences["contents_raw"]
      differences["contents_raw"] = JsonDiff.diff(*differences["contents_raw"])
    end

    return unless differences.any?

    create(
      date: date,
      investigation: investigation,
      differences: differences,
    )
  end

  def change_completed?
    _before, after = differences["completion_status"]

    after == "Completed"
  end
end
