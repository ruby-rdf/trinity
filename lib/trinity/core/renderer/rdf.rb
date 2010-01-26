class Trinity::Renderer
  ##
  # RDF renderer.
  class RDF < Trinity::Renderer
    content_type 'text/plain'
    content_type 'text/turtle'
    content_type 'text/n3'

    include ::RDF

    def headers
      super.merge({'Content-Type' => 'text/plain'}) # FIXME
    end

    def content
      RDF::Writer.for(:ntriples).buffer do |writer| # FIXME
        resource.each { |statement| writer << statement }
      end
    end
  end
end
