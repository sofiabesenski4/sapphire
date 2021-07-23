require "pry"
require "./lib/router"
class Application
  def initialize
    @router= Router.new
  end

  def call(env)
    router.call(env)

  end

  private
  attr_reader :router

end
