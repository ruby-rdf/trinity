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
      query([env['trinity.subject'], RDF::OWL.sameAs]).each do |statement|
        env['trinity.subject'] = statement.object
      end
      super
    end
  end
end
