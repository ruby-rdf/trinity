class Trinity::Handler
  ##
  # URL redirection support.
  #
  # If a resource has a "see also" property, this handler performs a
  # redirect to the value of that property.
  #
  # @see http://www.w3.org/TR/2000/CR-rdf-schema-20000327/#s2.3.4
  class Redirector < Trinity::Handler
    def call(env)
      query([env['trinity.subject'], RDF::RDFS.seeAlso]).each do |statement|
        return redirect(statement.object.to_s)
      end
      super
    end
  end
end
