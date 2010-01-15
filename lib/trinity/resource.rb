module Trinity
  ##
  class Resource
    include RDF::Enumerable

    attr_reader :url
    attr_reader :data

    def initialize(url, data = [])
      @url, @data = RDF::URI.new(url.to_s), data
    end

    def found?
      !empty?
    end

    def each(&block)
      data.each(&block)
    end

    def render(env)
      Renderer.for(env).new(env).render(self)
    end
  end
end
