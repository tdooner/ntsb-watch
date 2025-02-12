class DailySyncDifference < ApplicationRecord
  belongs_to :investigation

  def self.create_from_changed_investigation(date, investigation)
    differences = investigation.changes.dup

    if differences["contents_raw"]
      differences["contents_raw"] = JsonDiff.diff(*differences["contents_raw"])
    end

    create(
      date: date,
      investigation: investigation,
      differences: differences,
    )
  end
end
