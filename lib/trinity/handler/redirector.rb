class Trinity::Handler
  ##
  class Redirector < Trinity::Handler
    def call(env)
      query([env['trinity.subject'], RDF::RDFS.seeAlso]).each do |statement|
        return redirect(statement.object.to_s)
      end
      super
    end
  end
end
