class Trinity::Handler
  ##
  class Admin < Trinity::Handler
    
    def initialize(application, repository)
      @app = application
      @repository = repository
    end

    def call(env)
      [200, {'Content-Type' => 'text/javascript'}, "//TODO: Javascript to come here."]
    end
  end
end
