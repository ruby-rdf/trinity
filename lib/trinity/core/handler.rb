module Trinity
  ##
  class Handler
    autoload :Initializer, 'trinity/core/handler/initializer'
    autoload :Acceptor,    'trinity/core/handler/acceptor'
    autoload :Aliaser,     'trinity/core/handler/aliaser'
    autoload :Redirector,  'trinity/core/handler/redirector'
    autoload :Loader,      'trinity/core/handler/loader'
    autoload :Reasoner,    'trinity/core/handler/reasoner'
    autoload :Dispatcher,  'trinity/core/handler/dispatcher'
    autoload :Admin,       'trinity/core/handler/admin'

    attr_reader :application
    attr_reader :repository

    def initialize(application, repository = nil)
      @application = application
      @repository  = repository
    end

    def call(env)
      application.call(env)
    end

    ##
    # Queries the repository for statements matching the given pattern.
    #
    # @param  [RDF::Query, RDF::Statement, Array(RDF::Value)] pattern
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

    def not_found
      [404, {'Content-Type' => 'text/plain'}, '404 Resource Not Found']
    end
  end
end
