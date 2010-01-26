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
        table(:id => :statements) do
          thead do
            # TODO
          end
          tbody do
            renderer.data.each do |statement|
              tr(:class => statement) do
                td(:class => :predicate) do
                  text theme.render_predicate(statement)
                end
                td(:class => :object) do
                  text theme.render_object(statement)
                end
              end
            end
          end
        end
      end
    end

    ##
    # @param  [RDF::Statement] statement
    # @return [String]
    def self.render_predicate(statement)
      escape_string(render_value(statement.predicate))
    end

    ##
    # @param  [RDF::Statement] statement
    # @return [String]
    def self.render_object(statement)
      escape_string(render_value(statement.object))
    end

    ##
    # @param  [String] string
    # @return [String]
    def self.escape_string(string)
      ERB::Util.html_escape(string)
    end

    ##
    # @param  [RDF::Value] value
    # @return [String]
    def self.render_value(value)
      value.inspect # TODO
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
