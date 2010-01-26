require 'markaby'

module Trinity
  ##
  # Theme plugin for Trinity.
  class Theme < Trinity::Plugin
    URI = RDF::URI.new('http://gemcutter.org/gems/trinity-theme') 
    NS  = RDF::Vocabulary.new("#{URI}#")

    def self.initialize!(application)
      application.map('/theme.css', CSS)
      application.map('/theme.js',  JS)
    end

    ##
    class CSS < Trinity::Handler
      def call(env)
        [200, {}, ['/* TODO */']]
      end
    end

    ##
    class JS < Trinity::Handler
      def call(env)
        [200, {}, ['/* TODO */']]
      end
    end

    ##
    # @param  [Builder]
    # @return [void]
    def self.render_html_head(renderer)
      renderer.html do
        link   :type => 'text/css', :rel => :stylesheet, :media => 'screen', :href => '/theme.css'
        script :type => 'text/javascript', :language => :javascript, :src => '/theme.js'
      end
    end

    ##
    # @param  [Builder]
    # @return [void]
    def self.render_html_body(renderer)
      self.render_html_block(renderer, :header)
      self.render_html_block(renderer, :title)
      self.render_html_block(renderer, :document)
      self.render_html_block(renderer, :footer)
    end

    ##
    # @param  [Builder]
    # @param  [Symbol, String, #to_s]
    # @return [void]
    def self.render_html_block(renderer, id)
      this = self
      renderer.html do
        div(:id => id) { this.send("render_#{id}_block", renderer) }
      end
    end

    ##
    # @param  [Builder]
    # @return [void]
    def self.render_header_block(renderer)
      # TODO
    end

    ##
    # @param  [Builder]
    # @return [void]
    def self.render_title_block(renderer)
      widget(renderer, ::RDF::DC.title, ::RDF::RDFS.label) rescue nil
    end

    ##
    # @param  [Builder]
    # @return [void]
    def self.render_document_block(renderer)
      widget(renderer, ::RDF::DC.description, ::RDF::RDFS.comment) rescue nil
    end

    ##
    # @param  [Builder]
    # @return [void]
    def self.render_footer_block(renderer)
      # TODO
    end

    ##
    # @param  [RDF::URI] predicate
    # @return [Widget]
    def self.widget(renderer, *predicates)
      predicates.each do |predicate|
        if object = renderer.data.query([renderer.subject, predicate]).first.object rescue nil
          widget = Trinity::Widget.for(predicate).new(object, :predicate => predicate)
          return widget.content(renderer.builder)
        end
     end
    end
  end
end
