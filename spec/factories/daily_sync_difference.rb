FactoryBot.define do
  factory :daily_sync_difference do
    investigation
    date { Date.today }
    differences { [] }
  end
end
