class Trinity::Handler
  ##
  class Initializer < Trinity::Handler
    def call(env)
      env['trinity.resource'] = RDF::URI.new(Addressable::URI.new({
        :scheme => env['rack.url_scheme'],
        :host   => env['SERVER_NAME'],
        :port   => env['SERVER_PORT'],
        :path   => env['REQUEST_URI'],
        :query  => env['QUERY_STRING'].to_s.size > 0 ? env['QUERY_STRING'] : nil,
      }))
      env['trinity.subject'] = env['trinity.resource']
      super
    end
  end
end
