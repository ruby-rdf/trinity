require 'markaby'

class Trinity::Renderer
  ##
  # HTML renderer.
  class HTML < Trinity::Renderer
    content_type 'application/xhtml+xml'
    content_type 'text/html'

    ##
    # Returns the HTTP content for the response.
    #
    # @return [String]
    def content
      this = self # needed because Markaby uses `instance_eval`
      xml = Markaby::Builder.new(:indent => 2)
      xml.instruct!
      xml.declare! :DOCTYPE, :html, :PUBLIC, "-//W3C//DTD XHTML+RDFa 1.0//EN", "http://www.w3.org/MarkUp/DTD/xhtml-rdfa-1.dtd"
      xml.html(:xmlns => 'http://www.w3.org/1999/xhtml') do
        head do
          title  this.title
          link :type => 'text/css', :rel => :stylesheet, :media => 'screen', :href => '/trinity.css'
          script :type => 'text/javascript', :language => :javascript, :src => '/trinity.js'
        end
        body do
          div(:id => :header) do
            this.header(self)
          end
          h1 this.title
          div(:id => :document) do
            this.document(self)
          end
          div(:id => :footer) do
            this.footer(self)
          end
        end
      end
      xml.to_s
    end

    ##
    # @return [String]
    def title
      @title ||= data.query([subject, ::RDF::RDFS.label]).first.object.value
    end

    ##
    # @param  [Markaby::Builder]
    # @return [void]
    def header(html)
      # TODO
    end

    ##
    # @param  [Markaby::Builder]
    # @return [void]
    def document(html)
      html.text @description ||= data.query([subject, ::RDF::RDFS.comment]).first.object.value
    end

    ##
    # @param  [Markaby::Builder]
    # @return [void]
    def footer(html)
      # TODO
    end
  end
end
