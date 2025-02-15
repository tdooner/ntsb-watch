require "rails_helper"

RSpec.describe JsonDiff do
  describe ".diff" do
    it "diffs two simple hashes" do
      expect(described_class.diff(
        { "foo" => { "bar" => "baz" } },
        { "foo" => { "bar" => "bazzz" } }
      )).to eq({
        "foo.bar" => [ "baz", "bazzz" ]
      })
    end

    it "diffs hashes with nested arrays" do
      expect(described_class.diff(
        { "foo" => [ { "bar" => "baz" } ] },
        { "foo" => [ { "bar" => "bazzz" } ] }
      )).to eq({
        "foo[0].bar" => [ "baz", "bazzz" ]
      })
    end

    it "does not output a diff if a new key is nil" do
      expect(described_class.diff(
        { "foo" => {} },
        { "foo" => { "other" => nil } }
      )).to eq({})
    end
  end
end
