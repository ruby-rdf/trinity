class Trinity::Handler
  ##
  # Initialization.
  #
  # Initializes the appropriate Rack environment variables with a valid
  # resource URI that will be used as the initial subject during the current
  # request.
  class Initializer < Trinity::Handler
    attr_reader :options

    def initialize(application, repository = nil, options = {})
      @options = options
      super(application, repository)
    end

    def call(env)
      set_resource_uri(env)
      set_subject_uri(env)
      super
    end

    def set_resource_uri(env)
      env['trinity.resource'] = RDF::URI.new(Addressable::URI.new({
        :scheme => env['rack.url_scheme'],
        :host   => options[:host] || env['SERVER_NAME'],
        :port   => options[:port] || env['SERVER_PORT'],
        :path   => env['REQUEST_URI'],
        :query  => env['QUERY_STRING'].to_s.size > 0 ? env['QUERY_STRING'] : nil,
      }))
    end

    def set_subject_uri(env)
      env['trinity.subject'] = env['trinity.resource']
    end
  end
end
