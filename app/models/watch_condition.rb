# typed: true

class WatchCondition < ApplicationRecord
  extend T::Sig

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

  # Keep this in-sync with the matching_investigations conditions above as best as possible.
  # This is used to reconstitute which WatchCondition returned the result.
  sig { params(investigation: Investigation).returns(T::Boolean) }
  def matches_investigation?(investigation)
    case condition_key
    when "registrationNumber"
      Array(investigation.contents_raw["cm_vehicles"]).any? { |vehicle| vehicle["registrationNumber"] == condition_value }
    when "prelimNarrative"
      (investigation.contents_raw["prelimNarrative"] || "").downcase.include?(T.must(condition_value).downcase)
    when "airportId"
      [
        condition_value,
        "K#{condition_value}"
      ].include?(investigation.contents_raw["airportId"])
    end
  end
end
