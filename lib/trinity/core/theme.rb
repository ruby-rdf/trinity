module Trinity
  ##
  # Base class for Trinity themes.
  class Theme < Trinity::Plugin
    extend Enumerable

    ##
    # Enumerates loaded Trinity theme classes.
    #
    # @yield  [klass]
    # @yieldparam [Class]
    # @return [Enumerator]
    def self.each(&block)
      @@subclasses.each(&block)
    end

    private

      @@subclasses = [] # @private

      def self.inherited(child) # @private
        @@subclasses << child unless @@subclasses.include?(child)
        super
      end

  end
end
