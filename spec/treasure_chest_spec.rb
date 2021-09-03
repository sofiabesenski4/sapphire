require "./lib/sapphire/treasure_chest"
require "pry"
RSpec.describe Sapphire::TreasureChest do
  describe(".config") do
    subject { described_class.config("./spec/fixture/testing_config.json")["db"] }

    it "contains the expected keys" do
      expect(subject["host"]).to eq "test"
      expect(subject["port"]).to eq 123
      expect(subject["username"]).to eq "test_user"
      expect(subject["password"]).to eq "test_pass"
      expect(subject["db_name"]).to eq "test_db"
    end
  end
end
