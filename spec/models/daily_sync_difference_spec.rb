require "rails_helper"

RSpec.describe DailySyncDifference do
  describe ".create_from_changed_investigation" do
    let(:date) { Date.today }
    let(:investigation) { FactoryBot.create(:investigation) }
    let(:updated_json) do
      investigation.contents_raw.tap do |json|
        json["cm_docketOriginalPublishDate"] = "2025-02-12T18:00:00Z"
      end
    end
    let(:changed_investigation) do
      Investigation.find_or_initialize_from_json(updated_json)
    end
    let(:daily_sync_difference) do
      DailySyncDifference.create_from_changed_investigation(date, changed_investigation)
    end

    it "stores a difference to the contents_raw" do
      expect(daily_sync_difference).to have_attributes(
        date: date,
        investigation: changed_investigation,
        differences: {
          "contents_raw" => {
            "cm_docketOriginalPublishDate" => [ nil, "2025-02-12T18:00:00Z" ]
          }
        }
      )
    end

    context "when there is only a 1-hour change to event_date" do
      let(:updated_json) do
        investigation.contents_raw.tap do |json|
          json["cm_eventDate"] = (investigation.event_date + 1.hour).iso8601
        end
      end

      it "ignores the change" do
        expect do
          expect(daily_sync_difference).to be_nil
        end.not_to change(DailySyncDifference, :count)
      end
    end
  end
end
