module Trinity
  ##
  # Administration plugin for Trinity.
  class Admin < Trinity::Plugin
    URI = RDF::URI.new('http://gemcutter.org/gems/trinity-admin') 
    NS  = RDF::Vocabulary.new("#{URI}#")

    def self.initialize!(application)
      # TODO
    end
  end
end
