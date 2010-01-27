class Trinity::Handler
  ##
  # File extension support.
  #
  # Determines if a resource was requested with a specific file extension
  # (e.g. `http://resource/uri.xml` or `http://resource/uri.json`) and sets
  # the current Trinity subject to to the specified URI minus the file
  # extension, as well as rewriting the HTTP_ACCEPT header which is used
  # later for rendering.
  class Acceptor < Trinity::Handler
    def call(env)
      if query([env['trinity.subject']]).empty?
        subject = env['trinity.subject'].to_s
        if extension = File.extname(subject)
          types   = MIME::Types.type_for(File.basename(subject))
          subject = subject[0...-extension.size]
          unless query([RDF::URI.new(subject)]).empty? || types.empty?
            env['trinity.subject'] = RDF::URI.new(subject)
            env['HTTP_ACCEPT']     = env['HTTP_ACCEPT'].split(',').unshift(types.first.to_s).join(',') if env['HTTP_ACCEPT']
          end
        end
      end
      super
    end
  end
end
