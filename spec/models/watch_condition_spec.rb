require 'rails_helper'

RSpec.describe WatchCondition, type: :model do
  describe "#matching_investigations" do
    let!(:investigation) { create(:investigation, fixture_name: "N666DS.json") }

    subject { watch_condition.matching_investigations }

    context "for condition_key = registrationNumber" do
      context "for a matching condition_value" do
        let(:watch_condition) { create(:watch_condition, condition_key: "registrationNumber", condition_value: "N666DS") }

        it { is_expected.to include(investigation) }
      end

      context "for a non-matching condition_value" do
        let(:watch_condition) { create(:watch_condition, condition_key: "registrationNumber", condition_value: "N123TD") }

        it { is_expected.not_to include(investigation) }
      end
    end

    context "for condition_key = prelimNarrative" do
      context "for a matching condition_value" do
        let(:watch_condition) { create(:watch_condition, condition_key: "prelimNarrative", condition_value: "Part 91") }

        it { is_expected.to include(investigation) }
      end

      context "for a non-matching condition_value" do
        let(:watch_condition) { create(:watch_condition, condition_key: "prelimNarrative", condition_value: "Part 121") }

        it { is_expected.not_to include(investigation) }
      end
    end
  end
end
