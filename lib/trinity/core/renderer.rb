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
      if env['HTTP_ACCEPT']
        env['HTTP_ACCEPT'].split(',').each do |content_type_and_weight|
          content_type, weight = content_type_and_weight.split(';')
          each do |klass|
            return klass if klass.content_types.include?(content_type)
          end
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

    ##
    # @param  [Hash{String => Object}] env
    def initialize(env)
      @env = env
    end

    ##
    # Returns the RDF subject for this request.
    #
    # @return [RDF::URI]
    def subject
      env['trinity.subject']
    end

    ##
    # Returns the RDF data for this request.
    #
    # @return [RDF::Queryable]
    def data
      env['trinity.data']
    end

    def render(resource, options = {})
      @resource = resource
      [status, headers, [content]]
    end

    ##
    # Returns the HTTP headers for the response.
    #
    # @return [Hash{String => String}]
    def headers
      if content_type = self.class.content_type
        {'Content-Type' => content_type}
      else
        {}
      end
    end

    ##
    # Returns the HTTP status code for the response.
    #
    # @return [Integer]
    def status
      200 # OK
    end

    ##
    # Returns the HTTP content for the response.
    #
    # @return [String]
    # @abstract
    def content
      raise NotImplementedError
    end

    private

      @@subclasses = [] # @private

      def self.inherited(child) # @private
        @@subclasses << child unless @@subclasses.include?(child)
        super
      end

    require 'trinity/core/renderer/rdf'
    require 'trinity/core/renderer/html'
  end
end
