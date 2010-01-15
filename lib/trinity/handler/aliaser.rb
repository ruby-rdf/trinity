class Trinity::Handler
  ##
  class Aliaser < Trinity::Handler
    def call(env)
      query([env['trinity.subject'], RDF::OWL.sameAs]).each do |statement|
        env['trinity.subject'] = statement.object
      end
      super
    end
  end
end
