require 'markaby'

class Trinity::Renderer
  ##
  # HTML renderer.
  class HTML < Trinity::Renderer
    content_type 'application/xhtml+xml'
    content_type 'text/html'

    attr_reader :builder

    def html(&block)
      if block_given?
        case block.arity
          when 1 then block.call(builder)
          else builder.instance_eval(&block)
        end
      end
    end

    ##
    # @return [Class]
    def theme_class
      require theme_path
      Trinity::Theme::Data # FIXME
    end

    ##
    # @return [String]
    def theme_path
      File.join('trinity', 'theme', theme_name)
    end

    ##
    # @return [String]
    def theme_name
      'data' # TODO: query RDF repository
    end

    ##
    # Returns the HTTP content for the response.
    #
    # @return [String]
    def content
      require theme_path
      this = self # needed because Markaby is based on `instance_eval`
      @builder = Trinity::Builder.new(:indent => 2)
      @builder.instruct!
      @builder.declare! :DOCTYPE, :html, :PUBLIC, "-//W3C//DTD XHTML+RDFa 1.0//EN", "http://www.w3.org/MarkUp/DTD/xhtml-rdfa-1.dtd"
      @builder.html(:xmlns => 'http://www.w3.org/1999/xhtml') do
        head { this.render_html_head }
        body { this.render_html_body }
      end
      @builder.to_s
    end

    ##
    # @param  [Builder] html
    # @return [void]
    def render_html_head
      builder.title  'Trinity' # FIXME
      Trinity::Plugin.invoke(:render_html_head, self)
    end

    ##
    # @param  [Builder] html
    # @return [void]
    def render_html_body
      Trinity::Plugin.invoke(:render_html_body, self)
    end
  end
end
