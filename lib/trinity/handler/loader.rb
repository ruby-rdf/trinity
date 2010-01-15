class Trinity::Handler
  ##
  class Loader < Trinity::Handler
    def call(env)
      env['trinity.data'] = query([env['trinity.subject']])
      super
    end
  end
end
