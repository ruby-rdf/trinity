class Trinity::Handler
  ##
  # URL aliasing support.
  #
  # If a resource has been declared to be the same as another resource,
  # changes the current request subject to be that resource instead.
  #
  # @see http://www.w3.org/TR/owl-ref/#sameAs-def
  class Aliaser < Trinity::Handler
    def call(env)
      # NB: if more than one matching statement is found, we will
      # effectively use the last found one:
      subjects = [env['trinity.subject']]
      object = nil
      while statement = query([env['trinity.subject'], RDF::OWL.sameAs]).first do
        object = statement.object
        return internal_error("Looping aliases") if subjects.include? object
        subjects << object
        env['trinity.subject'] = object
      end
      super
    end
  end
end
