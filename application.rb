require "pry"
require "./app/routes"
class Application
  def initialize
    @router = Routes.call
  end

  def call(env)
    response = router.call(env)
    [response.status, {"Content-Type" => "text/html"}, [response.content]]
  end

  private

  attr_reader :router
end
