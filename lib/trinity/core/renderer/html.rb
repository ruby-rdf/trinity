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
          title  "Trinity" # FIXME
          link   :type => 'text/css', :rel => :stylesheet, :media => 'screen', :href => '/trinity.css'
          script :type => 'text/javascript', :language => :javascript, :src => '/trinity.js'
        end
        body do
          div(:id => :header)   { this.header(self) }
          div(:id => :title)    { this.title(self) }
          div(:id => :document) { this.document(self) }
          div(:id => :footer)   { this.footer(self) }
        end
      end
      xml.to_s
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
    def title(html)
      widget(::RDF::DC.title, ::RDF::RDFS.label).content(html)
    end

    ##
    # @param  [Markaby::Builder]
    # @return [void]
    def document(html)
      widget(::RDF::DC.description, ::RDF::RDFS.comment).content(html)
    end

    ##
    # @param  [Markaby::Builder]
    # @return [void]
    def footer(html)
      # TODO
    end

    ##
    # @param  [RDF::URI] predicate
    # @return [Widget]
    def widget(*predicates)
      predicates.each do |predicate|
        if object = data.query([subject, predicate]).first.object rescue nil
          return Trinity::Widget.for(predicate).new(object, :predicate => predicate)
        end
     end
    end
  end
end
