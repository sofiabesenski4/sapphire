require "./lib/sapphire/router"
class Routes
  def self.call
    Sapphire::Router.new
      .get("/first_route") do
      "<h1>first</h1>"
    end
      .get("/second_route") do
      "hello"
    end
  end
end
