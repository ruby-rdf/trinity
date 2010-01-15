class Trinity::Renderer
  ##
  class RDF < Trinity::Renderer
    content_type 'text/plain'

    include ::RDF

    def headers
      super.merge({'Content-Type' => 'text/plain'}) # FIXME
    end

    def body
      RDF::Writer.for(:ntriples).buffer do |writer| # FIXME
        resource.each { |statement| writer << statement }
      end
    end
  end
end
