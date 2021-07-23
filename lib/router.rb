class Router
  def initialize
    @routes = []
  end

  def call (env)
    #search through list
    @routes.each do |route_hash|
      if env["REQUEST_METHOD"]==route_hash[:verb]
        if env["REQUEST_PATH"]==route_hash[:path]
          return route_hash[:returns].call
        end
      end
    end
    #routes.find {|e| e[env["REQUEST_METHOD"]] == }
    #return returns:
  end

  def get(arg, &block)
    @routes.push({verb: "GET", path: arg, returns: block})
  end

  def post
  end

  def patch
  end

  def delete
  end
end
