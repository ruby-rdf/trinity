class Trinity::Handler
  ##
  # Data loader.
  #
  # Loads all RDF statements about the current subject into the Rack
  # environment, where they are available to subsequent handlers.
  class Loader < Trinity::Handler
    ##
    # @param  [Hash{String => Object}] env
    # @return [void]
    def call(env)
      load_data(env)
      load_plugins(env)
      super
    end

    ##
    # @param  [Hash{String => Object}] env
    # @return [void]
    def load_data(env)
      # FIXME: remove the .extend(...) after RDF.rb 0.0.9 is released:
      env['trinity.data'] = query([env['trinity.subject']]).extend(RDF::Enumerable, RDF::Queryable)
    end

    ##
    # @param  [Hash{String => Object}] env
    # @return [void]
    def load_plugins(env)
      # FIXME: implement RDF::URI#each_parent to make this easier.
      require 'pathname' unless defined?(Pathname)
      if subject = RDF::URI.new(env['trinity.subject'].to_s) # FIXME: RDF::URI.dup
        path = Pathname.new(subject.path)
        loop do
          # TODO: we need a more appropriate predicate than doap:implements.
          query([subject, ::RDF::DOAP.implements]) do |statement|
            load_plugin(statement.object)
          end
          break if path.to_s == '/' || path.to_s.empty?
          subject.path = (path = path.parent).to_s
        end
      end
    end

    ##
    # @param  [RDF::URI] uri
    # @return [void]
    def load_plugin(uri)
      begin
        require uri.to_s['http://gemcutter.org/gems/'.size..-1].gsub('-', '/') # FIXME
      rescue LoadError => e
        # TODO: we should log the missing gem somewhere.
      end
    end
  end
end
