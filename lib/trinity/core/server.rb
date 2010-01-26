require 'thin'

module Trinity
  class Server
    def self.start(host, port, repository, options = {}, &block)
      Thin::Logging.debug = true if options[:debug]
      Thin::Server.start(host || '0.0.0.0', port || 3000, Trinity::Application.new(repository))
    end

    private_class_method :new
  end
end
