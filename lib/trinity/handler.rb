module Trinity
  ##
  class Handler
    autoload :Initializer, 'trinity/handler/initializer'
    autoload :Aliaser,     'trinity/handler/aliaser'
    autoload :Loader,      'trinity/handler/loader'
    autoload :Reasoner,    'trinity/handler/reasoner'

    attr_reader :application
    attr_reader :repository

    def initialize(application, repository = nil)
      @application = application
      @repository  = repository
    end

    def call(env)
      application.call(env)
    end

    def query(*args, &block)
      if block_given?
        repository.query(*args, &block)
      else
        repository.query(*args).extend(RDF::Enumerable)
      end
    end

    def redirect(url)
      [301, {'Content-Type' => 'text/plain', 'Location' => url}, "301 Moved Permanently to #{url}"]
    end
  end
end
