require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#watched_investigations" do
    let(:user) { create(:user) }
    let!(:investigation) { create(:investigation, fixture_name: "N666DS.json") }

    subject { user.watched_investigations }

    it { is_expected.to be_empty }

    context "when there is one matching and one non-matching condition" do
      let!(:watch_conditions) do
        [
          create(:watch_condition, user: user, condition_key: "registrationNumber", condition_value: "N666DS"),
          create(:watch_condition, user: user, condition_key: "prelimNarrative", condition_value: "NOT MATCHING -- THIS IS NOT IN THERE")
        ]
      end

      it { is_expected.to include(investigation) }
    end

    context "when there are two matching watch conditions" do
      let!(:watch_conditions) do
        [
          create(:watch_condition, user: user, condition_key: "registrationNumber", condition_value: "N666DS"),
          create(:watch_condition, user: user, condition_key: "prelimNarrative", condition_value: "Part 91")
        ]
      end

      it { is_expected.to include(investigation) }
    end
  end
end
