module Trinity
  ##
  class Application < Trinity::Handler
    ##
    # @param  [RDF::Repository] repository
    # @param  [Hash{Symbol => Object}] options
    def initialize(repository, options = {}, &block)
      this = self
      @repository  = repository
      @application = Rack::Builder.new do
        map(options[:path] || '/') do
          use Trinity::Handler::Initializer, repository, options
          use Trinity::Handler::Acceptor,    repository
          use Trinity::Handler::Aliaser,     repository
          use Trinity::Handler::Redirector,  repository
          use Trinity::Handler::Loader,      repository
          use Trinity::Handler::Reasoner,    repository
          run Trinity::Handler::Dispatcher.new(this, repository)
        end
      end
      Trinity::Plugin.invoke(:initialize!, self)
    end

    ##
    # Defines a URL path handler.
    #
    # @param  [String, #to_s] path
    # @yield
    # @return [void]
    def map(path, &block)
      application.map(path.to_s, &block)
    end
  end
end
