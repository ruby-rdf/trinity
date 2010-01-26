require 'erb'

module Trinity
  ##
  # Base class for widgets.
  class Widget
    extend  Enumerable
    include RDF

    ##
    # Enumerates loaded Trinity widget classes.
    #
    # @yield  [klass]
    # @yieldparam [Class]
    # @return [Enumerator]
    def self.each(&block)
      @@subclasses.each(&block)
    end

    ##
    # Returns a widget class for the given RDF `property`.
    #
    # @param  [RDF::URI] property
    # @return [Class]
    def self.for(property)
      # TODO: ultimately this should not be hardcoded.
      case property
        when RDFS.label, DC.title
          TextField
        when RDFS.comment, DC.description
          TextArea
      end
    end

    attr_accessor :value
    attr_reader   :options

    ##
    # @param  [String] value
    # @param  [Hash{Symbol => Object}] options
    def initialize(value, options = {})
      @value   = value
      @options = options
    end

    ##
    # @param  [Markaby::Builder] html
    # @return [void]
    # @abstract
    def content(html)
      html.text(ERB::Util.html_escape(value.inspect))
    end

    private

      @@subclasses = [] # @private

      def self.inherited(child) # @private
        @@subclasses << child
        super
      end

    require 'trinity/core/widget/text_field'
    require 'trinity/core/widget/text_area'
  end
end
