class Trinity::Handler
  ##
  # Determine if a resource was requested with a specific
  # file format (e.g. http://resource/uri.xml or 
  # http://resource/uri.json) and rewrite the subject to
  # be the specified URI minus the mime type and set the
  # appropriate HTTP_ACCEPT header. Used later for rendering.
  class Acceptor < Trinity::Handler
    def call(env)
      if query([env['trinity.subject']]).empty?
        subject = env['trinity.subject'].to_s
        if extension = File.extname(subject)
          types   = MIME::Types.type_for(File.basename(subject))
          subject = subject[0...-extension.size]
          unless query([RDF::URI.new(subject)]).empty? || types.empty?
            env['trinity.subject'] = RDF::URI.new(subject)
            env['HTTP_ACCEPT']     = env['HTTP_ACCEPT'].split(',').unshift(types.first.to_s).join(',')
          end
        end
      end
      super
    end
  end
end
