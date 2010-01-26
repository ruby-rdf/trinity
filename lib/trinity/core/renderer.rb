module Trinity
  ##
  class Renderer
    extend Enumerable

    ##
    # Enumerates known renderer classes.
    #
    # @yield  [klass]
    # @yieldparam [Class]
    # @return [Enumerator]
    def self.each(&block)
      @@subclasses.each(&block)
    end

    ##
    # Finds a renderer class based on the value of the `HTTP_ACCEPT` header.
    #
    # @param  [Hash{String => Object}] env
    # @return [Class]
    def self.for(env)
      # TODO: add support for wildcards and explicit weights.
      env['HTTP_ACCEPT'].split(',').each do |content_type_and_weight|
        content_type, weight = content_type_and_weight.split(';')
        each do |klass|
          return klass if klass.content_types.include?(content_type)
        end
      end
      Renderer::RDF # the default
    end

    ##
    # Retrieves or defines the default MIME content type for this renderer class.
    #
    # @overload
    #   @return String
    #
    # @overload
    #   @param  [String, #to_s] type
    #   @return [void]
    #
    # @return [void]
    def self.content_type(type = nil)
      if type.nil?
        @content_types.first rescue nil
      else
        @content_types ||= []
        @content_types << type.to_s
      end
    end

    ##
    # Retrieves or defines the MIME content types for this renderer class.
    #
    # @overload
    #   @return [Array<String>]
    #
    # @overload
    #   @param  [Array<String>, #to_a] types
    #   @return [void]
    #
    # @return [void]
    def self.content_types(*types)
      if types.empty?
        @content_types || []
      else
        @content_types = types.to_a.map(&:to_s)
      end
    end

    attr_reader :env
    attr_reader :resource

    def initialize(env)
      @env = env
    end

    def render(resource, options = {})
      @resource = resource
      [status, headers, [content]]
    end

    def headers
      {}
    end

    def status
      200 # OK
    end

    ##
    # @abstract
    def content
      raise NotImplementedError
    end

    private

      @@subclasses = [] # @private

      def self.inherited(child) # @private
        @@subclasses << child
        super
      end

    require 'trinity/core/renderer/rdf'
    require 'trinity/core/renderer/html'
  end
end
