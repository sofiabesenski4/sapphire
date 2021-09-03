require "pry"
module Sapphire
  class Router
    Route = Struct.new(:verb, :path, :action, keyword_init: true)
    Response = Struct.new(:status, :content, keyword_init: true)
    def initialize
      @routes = []
    end

    def call(env)
      # search through list
      @incoming_req = Request.from_env(env)
      if (route = @routes.find { |route| matching?(route) })
        Response.new(content: route.action.call(@incoming_req), status: 200)
      elsif @fallback_action
        Response.new(content: @fallback_action.call(@incoming_req), status: 404)
      else
        Response.new(content: "Not found", status: 404)
      end
    end

    # hello/sitesearch
    def matching?(route)
      return false if @incoming_req.verb != route.verb

      # TODO get the query params!!!
      inc_path_chunks = @incoming_req.path.split("/")
      path_chunks = route.path.split("/")
      return false if inc_path_chunks.length != path_chunks.length

      inc_path_chunks.zip(path_chunks).map { |inc_chunk, route_chunk| chunk_match?(inc_chunk, route_chunk) }
    end

    def chunk_match?(inc_chunk, route_chunk)
      if route_chunk.start_with?(":")
        add_param(inc_chunk, route_chunk[1..])
        return true
      end

      inc_chunk == route_chunk
    end

    def add_param(param_value, param_key)
      @incoming_req.params[param_key.to_sym] = param_value
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

    def params
      @params ||= {}
    end

    def self.from_env(env)
      new(verb: env["REQUEST_METHOD"], path: env["REQUEST_PATH"])
    end

    def to_s
      path
    end
  end
end
