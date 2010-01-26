class Trinity::Handler
  ##
  # Initialize the appropriate environment variables
  # with a valid resource URI which will be used as the 
  # subject of the current request
  class Initializer < Trinity::Handler
    attr_reader :options

    def initialize(application, repository = nil, options = {})
      @options = options
      super(application, repository)
    end

    def call(env)
      env['trinity.resource'] = RDF::URI.new(Addressable::URI.new({
        :scheme => env['rack.url_scheme'],
        :host   => options[:host] || env['SERVER_NAME'],
        :port   => options[:port] || env['SERVER_PORT'],
        :path   => env['REQUEST_URI'],
        :query  => env['QUERY_STRING'].to_s.size > 0 ? env['QUERY_STRING'] : nil,
      }))
      env['trinity.subject'] = env['trinity.resource']
      super
    end
  end
end
