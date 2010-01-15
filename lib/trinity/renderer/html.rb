class Trinity::Renderer
  ##
  class HTML < Trinity::Renderer
    content_type 'application/xhtml+xml'
    content_type 'text/html'

    def headers
      super.merge({'Content-Type' => self.class.content_type})
    end

    def body
      '' # TODO
    end
  end
end
