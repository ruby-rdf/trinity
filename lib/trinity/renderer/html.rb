require 'markaby'

class Trinity::Renderer
  ##
  class HTML < Trinity::Renderer
    content_type 'application/xhtml+xml'
    content_type 'text/html'

    def headers
      super.merge({'Content-Type' => self.class.content_type})
    end

    def content
      xml = Markaby::Builder.new(:indent => 2)
      xml.instruct!
      xml.declare! :DOCTYPE, :html, :PUBLIC, "-//W3C//DTD XHTML+RDFa 1.0//EN", "http://www.w3.org/MarkUp/DTD/xhtml-rdfa-1.dtd"
      xml.html(:xmlns => 'http://www.w3.org/1999/xhtml') do
        head do
          title "Trinity" # TODO
        end
        body do
          h1 "Hello, world!" # TODO
        end
      end
      xml.to_s
    end
  end
end
