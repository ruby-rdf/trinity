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
      env['HTTP_ACCEPT'].split(',').each do |value|
        content_type, weight = value.split(';')
        each do |klass|
          return klass if klass.content_type == content_type
        end
      end
      Renderer::RDF # the default
    end

    def self.content_type(type = nil)
      if type.nil?
        @content_types.first rescue nil
      else
        @content_types ||= []
        @content_types << type
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
