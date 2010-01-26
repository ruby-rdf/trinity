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
    end
  end
end
