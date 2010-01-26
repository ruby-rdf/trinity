module Trinity
  ##
  # Bitcache plugin for Trinity.
  #
  # @see http://bitcache.org/
  class Bitcache < Trinity::Plugin
    def self.initialize!
      require 'bitcache' unless defined?(::Bitcache)
    end
  end
end
