FactoryBot.define do
  factory :watch_condition do
    user

    condition_key { "registrationNumber" }
    condition_value { "N123TD" }
  end
end
