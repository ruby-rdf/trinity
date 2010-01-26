module Trinity
  ##
  # Administration plugin for Trinity.
  class Admin < Trinity::Plugin
    URI = RDF::URI.new('http://gemcutter.org/gems/trinity-admin') 
    NS  = RDF::Vocabulary.new("#{URI}#")

    def self.initialize!(application)
      application.map('/trinity.css', CSS)
      application.map('/trinity.js', JS)
    end

    ##
    class JS < Trinity::Handler
      def call(env)
        js_dir = File.expand_path(File.join(File.dirname(__FILE__), 'admin', 'js'))
        
        response = []

        # Include jquery
        File.open(File.join(js_dir, 'jquery-1.4.1.min.js'), 'r').each_line do |line|
          response << line
        end
        
        [200, {}, response]
      end
    end

    ##
    class CSS < Trinity::Handler
      def call(env)
        [200, {}, ['/* TODO */']]
      end
    end
  end
end
