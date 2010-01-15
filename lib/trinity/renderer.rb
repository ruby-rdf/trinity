module Trinity
  ##
  class Renderer
    autoload :RDF, 'trinity/renderer/rdf'

    def self.for(env)
      Renderer::RDF # FIXME
    end

    def self.content_type(type = nil)
      if type.nil?
        @content_types.first
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
      [status, headers, [body]]
    end

    def headers
      {}
    end

    def status
      200 # OK
    end

    ##
    # @abstract
    def body
      raise NotImplementedError
    end
  end
end
