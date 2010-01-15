class Trinity::Handler
  ##
  class Dispatcher < Trinity::Handler
    def call(env)
      if (resource = Resource.new(env['trinity.subject'], env['trinity.data'])).found?
        resource.render(env)
      else
        not_found
      end
    end
  end
end
