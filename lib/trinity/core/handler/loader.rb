class Trinity::Handler
  ##
  # Data loader.
  #
  # Loads all RDF statements about the current subject into the Rack
  # environment, where they are available to subsequent handlers.
  class Loader < Trinity::Handler
    def call(env)
      env['trinity.data'] = query([env['trinity.subject']])
      super
    end
  end
end
