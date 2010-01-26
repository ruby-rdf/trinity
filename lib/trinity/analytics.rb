module Trinity
  ##
  # Google Analytics plugin for Trinity.
  #
  # @see http://www.google.com/analytics/
  class Analytics < Trinity::Plugin
    NS = RDF::Vocabulary.new("http://gemcutter.org/gems/trinity-analytics#")

    def footer(html)
      # TODO
    end
  end
end
