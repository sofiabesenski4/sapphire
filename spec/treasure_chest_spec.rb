require "./lib/sapphire/treasure_chest"
require "pry"
RSpec.describe Sapphire::TreasureChest do
  describe(".config") do
    subject { described_class.config("./spec/fixture/testing_config.json")["db"] }

    it "contains the expected keys" do
      expect(subject["host"]).to eq "localhost"
      expect(subject["port"]).to eq 5432
      expect(subject["user"]).to eq "sofiabesenski"
      expect(subject["password"]).to eq ""
      expect(subject["dbname"]).to eq "test_db"
    end
  end

  describe(".create_table", focus: true) do
    before do
      spec_config = described_class.config("./spec/fixture/testing_config.json")
      allow(Sapphire::TreasureChest).to receive(:config).and_return(spec_config)
    end

    subject { described_class.create_table("test name", {column1: :int, column2: :str})}

    it "returns something" do
      expect(subject).not_to be_nil
    end
  end
end
