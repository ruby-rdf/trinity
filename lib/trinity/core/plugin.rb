module Trinity
  ##
  # Base class for Trinity plugins.
  class Plugin
    extend Enumerable

    ##
    # Enumerates loaded Trinity plugin classes.
    #
    # @yield  [klass]
    # @yieldparam [Class]
    # @return [Enumerator]
    def self.each(&block)
      @@subclasses.each(&block)
    end

    ##
    # Invokes the given `method` on all loaded plugin classes.
    #
    # @return [void]
    def self.invoke(method, *args, &block)
      @@subclasses.each do |plugin|
        plugin.send(method, *args, &block) if plugin.respond_to?(method)
      end
    end

    ##
    # @param  [Hash{Symbol => Object} options
    def initialize(options = {})
      # implement this in subclasses
    end

    protected

      ##
      # @abstract
      def self.install!
        # implement this in subclasses that need it
      end

      ##
      # @abstract
      def self.uninstall!
        # implement this in subclasses that need it
      end

      ##
      # @abstract
      def self.enable!
        # implement this in subclasses that need it
      end

      ##
      # @abstract
      def self.disable!
        # implement this in subclasses that need it
      end

      ##
      # @abstract
      def self.initialize!(application)
        # implement this in subclasses that need it
      end

    private

      @@subclasses = [] # @private

      def self.inherited(child) # @private
        @@subclasses << child
        super
      end

  end
end
