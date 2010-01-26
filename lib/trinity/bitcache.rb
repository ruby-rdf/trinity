module Trinity
  ##
  # Bitcache plugin for Trinity.
  #
  # @see http://bitcache.org/
  class Bitcache < Trinity::Plugin
    NS = RDF::Vocabulary.new("http://gemcutter.org/gems/trinity-bitcache#")

    def self.initialize!(application)
      require 'bitcache' unless defined?(::Bitcache)
    end
  end
end
