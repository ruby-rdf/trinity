module Trinity
  ##
  # Bitcache plugin for Trinity.
  #
  # @see http://bitcache.org/
  class Bitcache < Trinity::Plugin
    URI = RDF::URI.new('http://gemcutter.org/gems/trinity-bitcache') 
    NS  = RDF::Vocabulary.new("#{URI}#")

    def self.initialize!(application)
      require 'bitcache' unless defined?(::Bitcache)
      application.map('/bitcache', Server)
    end

    ##
    class Server < Trinity::Handler
      def call(env)
        [200, {'Content-Type' => 'text/plain'}, ['TODO']]
      end
    end
  end
end
