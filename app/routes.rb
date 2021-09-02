require "./lib/router"
class Routes
  def self.call
    Router.new
      .get("/first_route") do
      "<h1>first</h1>"
    end
      .get("/second_route") do
      "hello"
    end
  end
end
