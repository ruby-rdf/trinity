module Trinity
  ##
  # Google Analytics plugin for Trinity.
  #
  # @see http://www.google.com/analytics/
  class Analytics < Trinity::Plugin
    URI = RDF::URI.new('http://gemcutter.org/gems/trinity-analytics')
    NS  = RDF::Vocabulary.new("#{URI}#")

    def footer(html)
      # TODO
    end
  end
end
