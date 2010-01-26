class Trinity::Handler
  ##
  # Load the RDF statements about the current resource into the environment
  class Loader < Trinity::Handler
    def call(env)
      env['trinity.data'] = query([env['trinity.subject']])
      super
    end
  end
end
