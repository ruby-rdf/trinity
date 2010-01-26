class Trinity::Handler
  ##
  # Data loader.
  #
  # Loads all RDF statements about the current subject into the Rack
  # environment, where they are available to subsequent handlers.
  class Loader < Trinity::Handler
    def call(env)
      # FIXME: remove the .extend(...) after RDF.rb 0.0.9 is released:
      env['trinity.data'] = query([env['trinity.subject']]).extend(RDF::Enumerable, RDF::Queryable)
      super
    end
  end
end
