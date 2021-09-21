require "./lib/sapphire/jewel"
require "json"
require "pg"

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
      connect_to_db
      # this should return an instance of TreasureChest
      send_sql("CREATE TABLE #{table_name}")
    end

    def find(table_name:)
    end

    private

    def self.connect_to_db
      @@connect ||= PG.connect( config["db"] )
    end

    def self.send_sql(query)
      @@connect.exec (query)

    end

    def get_jewels
      # this is code taken directly from repo example
      conn.exec( "SELECT * FROM pg_stat_activity" ) do |result|
        puts "     PID | User             | Query"
        result.each do |row|
          puts " %7d | %-16s | %s " %
          row.values_at('pid', 'usename', 'query')
        end
      end
    end
  end
end
