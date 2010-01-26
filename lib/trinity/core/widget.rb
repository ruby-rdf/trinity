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

    attr_accessor :object
    attr_reader   :options

    ##
    # @param  [RDF::Value] object
    # @param  [Hash{Symbol => Object}] options
    # @option options [RDF::URI] :predicate (nil)
    # @option options [Boolean]  :editable (false)
    def initialize(object, options = {})
      @object  = object
      @options = options
    end

    ##
    # @param  [Builder] html
    # @return [void]
    # @abstract
    def content(html)
      html.text(ERB::Util.html_escape(object.inspect))
    end

    ##
    # @return [RDF::URI]
    def predicate
      options[:predicate]
    end

    ##
    # @return [Boolean]
    def editable?
      options[:editable] == true
    end

    private

      @@subclasses = [] # @private

      def self.inherited(child) # @private
        @@subclasses << child unless @@subclasses.include?(child)
        super
      end

    require 'trinity/core/widget/text_field'
    require 'trinity/core/widget/text_area'
  end
end
