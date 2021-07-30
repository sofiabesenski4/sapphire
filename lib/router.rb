class Router
  Route = Struct.new(:verb, :path, :action, keyword_init: true)
  Response = Struct.new(:status, :content, keyword_init: true)
  def initialize
    @routes = []
  end

  def call(env)
    # search through list
    req = Request.from_env(env)
    if route = @routes.find { |route| req.path == route.path && req.verb == route.verb }
      Response.new(content: route.action.call, status: 200)
    elsif @fallback_action
      Response.new(content: @fallback_action.call(req), status: 404)
    else
      Response.new(content: "Not found", status: 404)
    end
  end

  def get(arg, &block)
    @routes.push(Route.new(verb: "GET", path: arg, action: block))
    self
  end

  def post
  end

  def patch
  end

  def delete
  end

  def not_found(&block)
    @fallback_action = block
  end
end

class Request
  attr_reader :verb, :path
  def initialize(verb:, path:)
    @verb = verb
    @path = path
  end

  def self.from_env(env)
    new(verb: env["REQUEST_METHOD"], path: env["REQUEST_PATH"])
  end

  def to_s
    path
  end
end
