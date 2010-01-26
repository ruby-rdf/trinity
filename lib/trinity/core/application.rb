module Trinity
  ##
  class Application < Trinity::Handler
    def initialize(repository, options = {}, &block)
      this = self
      @repository  = repository
      @application = Rack::Builder.app do
        map('/trinity.js') do
          run Trinity::Handler::Admin.new(this, repository)
        end
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
      Trinity::Plugin.invoke :initialize!, @application
    end
  end
end
