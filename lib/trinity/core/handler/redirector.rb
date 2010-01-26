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
      subjects = [env['trinity.subject']]
      object = nil
      while statement = query([env['trinity.subject'], RDF::RDFS.seeAlso]).first do
        object = statement.object
        return internal_error("Looping redirects") if subjects.include? object
        subjects << object
        env['trinity.subject'] = object
      end
      return redirect(object.to_s) if object
      super
    end
  end
end
