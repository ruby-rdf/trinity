require 'markaby'

class Trinity::Theme
  ##
  # Theme plugin for Trinity.
  class Data < Trinity::Theme
    URI = RDF::URI.new('http://gemcutter.org/gems/trinity-theme') 
    NS  = RDF::Vocabulary.new("#{URI}#")

    ##
    # @param  [Application] application
    # @return [void]
    def self.initialize!(application)
      application.map('/theme/data.css', CSS)
      application.map('/theme/data.js',  JS)
    end

    ##
    # @param  [Renderer] renderer
    # @return [void]
    def self.render_html_head(renderer)
      renderer.html do
        link   :type => 'text/css', :rel => :stylesheet, :media => 'screen', :href => '/theme/data.css'
        script :type => 'text/javascript', :language => :javascript, :src => '/theme/data.js'
      end
    end

    ##
    # @param  [Renderer] renderer
    # @return [void]
    def self.render_html_body(renderer)
      theme = self
      renderer.html do
        div(:id => :header) do
          # TODO
        end
        div(:id => :content) do
          table(:id => :description) do
            thead do
              th { text 'Property' } # TODO: L10n
              th { text 'Value' }    # TODO: L10n
            end
            tbody do
              renderer.data.each do |statement|
                tr(:class => statement) do
                  td(:class => :predicate) do
                    theme.render_predicate(renderer, statement)
                  end
                  td(:class => :object) do
                    theme.render_object(renderer, statement)
                  end
                end
              end
            end
          end
        end
        div(:id => :footer) do
          # TODO
        end
      end
    end

    ##
    # @param  [Renderer]       renderer
    # @param  [RDF::Statement] statement
    # @return [String]
    def self.render_predicate(renderer, statement)
      escape_string("<#{statement.predicate}>")
    end

    ##
    # @param  [Renderer]       renderer
    # @param  [RDF::Statement] statement
    # @return [String]
    def self.render_object(renderer, statement)
      escape_string(render_value(renderer, statement.object))
    end

    ##
    # @param  [String] string
    # @return [String]
    def self.escape_string(string)
      ERB::Util.html_escape(string)
    end

    ##
    # @param  [Renderer]   renderer
    # @param  [RDF::Value] value
    # @return [String]
    def self.render_value(renderer, value)
      case value
        when RDF::URI
          "<#{value}>"
        when RDF::Node
          value.to_s
        when RDF::Literal
          value.to_s
        else
          value.inspect
      end
    end

    ##
    class CSS < Trinity::Handler
      def call(env)
        [200, {'Content-Type' => 'text/css'}, [content]]
      end

      def content
        '/* TODO */'
      end
    end

    ##
    class JS < Trinity::Handler
      def call(env)
        [200, {'Content-Type' => 'text/javascript'}, [content]]
      end

      def content
        '/* TODO */'
      end
    end
  end
end
