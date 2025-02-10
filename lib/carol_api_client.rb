require "uri"
require "net/http"
require "zip"

class CarolApiClient
  BASE_URL = URI("https://data.ntsb.gov")

  def investigations(start_date, end_date)
    return to_enum(:investigations, start_date, end_date) unless block_given?

    response = Net::HTTP.post(
      URI.join(BASE_URL, "/carol-main-public/api/Query/FileExport"),
      query(start_date, end_date).to_json,
      { "Content-Type" => "application/json", "Accept" => "application/json" }
    )

    zipfile = Zip::InputStream.open(StringIO.new(response.body))
    while (entry = zipfile.get_next_entry)
      next unless entry.name =~ /cases.*\.json/

      JSON.parse(entry.get_input_stream.read).each do |result|
        yield result
      end
    end
  end

  private

  def query(start_date, end_date)
    {
      "QueryGroups" => [
        {
          "QueryRules" => [
            { "FieldName" => "NTSBNumber", "RuleType" => 0, "Values" => [], "Columns" => [ "Event.NTSBNumber" ], "Operator" => "search engine" },
            { "FieldName" => "Mode", "RuleType" => 0, "Values" => [ "Aviation" ], "Columns" => [ "Event.Mode" ], "Operator" => "contains" },
            { "FieldName" => "EventDate", "RuleType" => 0, "Values" => [ start_date, end_date ], "Columns" => [ "Event.EventDate" ], "Operator" => "is in the range" },
            { "FieldName" => "City", "RuleType" => 0, "Values" => [], "Columns" => [ "Event.City" ], "Operator" => "search engine" },
            { "FieldName" => "State", "RuleType" => 0, "Values" => [], "Columns" => [ "Event.State" ], "Operator" => "is" },
            { "FieldName" => "Country", "RuleType" => 0, "Values" => [], "Columns" => [ "Event.Country" ], "Operator" => "is" },
            { "FieldName" => "HighestInjury", "RuleType" => 0, "Values" => [], "Columns" => [ "Event.HighestInjury" ], "Operator" => "is" },
            { "FieldName" => "OriginalPublishedDate", "RuleType" => 0, "Values" => [], "Columns" => [ "Event.OriginalPublishedDate" ], "Operator" => "is" },
            { "FieldName" => "AircraftCategory", "RuleType" => 0, "Values" => [], "Columns" => [ "Aircraft.AircraftCategory" ], "Operator" => "is" },
            { "FieldName" => "EngineType", "RuleType" => 0, "Values" => [], "Columns" => [ "Aircraft.EngineType" ], "Operator" => "is" },
            { "FieldName" => "RegistrationNumber", "RuleType" => 0, "Values" => [], "Columns" => [ "Aircraft.RegistrationNumber" ], "Operator" => "search engine" },
            { "FieldName" => "RegulationFlightConductedUnder", "RuleType" => 0, "Values" => [], "Columns" => [ "AviationOperation.RegulationFlightConductedUnder" ], "Operator" => "is" },
            { "FieldName" => "OperatorScope", "RuleType" => 0, "Values" => [], "Columns" => [ "AviationOperation.OperatorScope" ], "Operator" => "is" },
            { "FieldName" => "RecNum", "RuleType" => 0, "Values" => [], "Columns" => [ "Recs.Srid", "Recs.SridCleaned" ], "Operator" => "search engine" },
            { "FieldName" => "RecsSubject", "RuleType" => 0, "Values" => [], "Columns" => [ "Recs.Subject" ], "Operator" => "search engine" },
            { "FieldName" => "AddresseeName", "RuleType" => 0, "Values" => [], "Columns" => [ "Recs.AddresseeName" ], "Operator" => "search engine" }
          ],
         "AndOr" => "And"
        }
      ],
      "TargetCollection" => "cases",
      "AndOr" => "And",
      "SortColumn" => nil,
      "SortDescending" => true,
      "SessionId" => 71686,
      "ExportFormat" => "data",
      "ResultSetSize" => 500
    }
  end
end
