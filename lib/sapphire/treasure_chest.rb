require "./lib/sapphire/jewel"
require "json"

module Sapphire
  class TreasureChest
    def self.config(config_path = "./config.json")
      File.open(config_path) do |file|
        JSON.parse(file.read)
      end
    end

    def intialize
    end

    def self.create_table(table_name, schema)
    end
  end
end
