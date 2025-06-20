class WatchCondition < ApplicationRecord
  VALID_KEYS = %i[
    registrationNumber
    prelimNarrative
    airportId
  ]

  belongs_to :user
  enum :condition_key, VALID_KEYS.map { |i| [i, i.to_s] }.to_h

  def matching_investigations
    case condition_key
    when "registrationNumber"
      Investigation.where("jsonb_path_exists(contents_raw, ('$.cm_vehicles[*].registrationNumber ? (@ == \"' || :value || '\")')::jsonpath)", value: condition_value)
    when "prelimNarrative"
      Investigation.where("contents_raw->>'prelimNarrative' ilike ?", "%#{condition_value}%")
    when "airportId"
      Investigation.where("contents_raw->>'airportId' = ? OR contents_raw->>'airportId' = ?", condition_value, "K#{condition_value}")
    end
  end
end
