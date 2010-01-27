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
      render_uri(renderer, statement.predicate)
    end

    ##
    # @param  [Renderer]       renderer
    # @param  [RDF::Statement] statement
    # @return [String]
    def self.render_object(renderer, statement)
      case value = statement.object
        when RDF::Literal
          render_literal(renderer, value)
        when RDF::URI
          render_uri(renderer, value)
        when RDF::Node
          render_node(renderer, value)
        else
          value = escape_string(value.inspect)
      end
    end

    ##
    # @param  [Renderer] renderer
    # @param  [RDF::URI] uri
    # @return [String]
    def self.render_uri(renderer, uri)
      value = escape_string(uri.to_s)
      renderer.html do
        a(:href => value) { value }
      end
    end

    ##
    # @param  [Renderer]  renderer
    # @param  [RDF::Node] node
    # @return [String]
    def self.render_node(renderer, node)
      value = escape_string(node.to_s)
      renderer.html do
        text(value)
      end
    end

    ##
    # @param  [Renderer]     renderer
    # @param  [RDF::Literal] literal
    # @return [String]
    def self.render_literal(renderer, literal)
      value = escape_string(literal.value.to_s)
      case
        when literal.datatyped?
          type  = literal.datatype
          value = case type
            when XSD.string, nil
              value
            else
              value # TODO
          end
          renderer.html do
            span(:class => 'literal') { value } # FIXME
          end
        when literal.language?
          lang = escape_string(literal.language.to_s)
          renderer.html do
            span(:class => 'literal', 'xml:lang' => lang, :title => lang) { value }
          end
        else
          renderer.html do
            span(:class => 'literal') { value }
          end
      end
    end

    ##
    # @param  [String] string
    # @return [String]
    def self.escape_string(string)
      ERB::Util.html_escape(string)
    end

    ##
    class CSS < Trinity::Handler
      def call(env)
        [200, {'Content-Type' => 'text/css'}, [content]]
      end

      def content
        File.read(File.join(File.dirname(__FILE__), 'data.css'))
      end
    end

    ##
    class JS < Trinity::Handler
      def call(env)
        [200, {'Content-Type' => 'text/javascript'}, [content]]
      end

      def content
        File.read(File.join(File.dirname(__FILE__), 'data.js'))
      end
    end
  end
end
