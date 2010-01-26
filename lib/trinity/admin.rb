module Trinity
  ##
  # Administration plugin for Trinity.
  class Admin < Trinity::Plugin
    URI = RDF::URI.new('http://gemcutter.org/gems/trinity-admin') 
    NS  = RDF::Vocabulary.new("#{URI}#")

    def self.initialize!(application)
      application.map('/trinity.css') { run CSS.new(application) }
      application.map('/trinity.js')  { run JS.new(application) }
    end

    ##
    class JS < Trinity::Handler
      def call(env)
        [200, {}, ['/* TODO */']]
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
