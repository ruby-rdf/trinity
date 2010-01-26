require 'addressable/uri'
require 'mime/types'
require 'rack'
require 'rdf'
require 'rdf/ntriples'
require 'trinity/version'

module Trinity
  autoload :Application, 'trinity/core/application'
  autoload :Builder,     'trinity/core/builder'
  autoload :Handler,     'trinity/core/handler'
  autoload :Plugin,      'trinity/core/plugin'
  autoload :Renderer,    'trinity/core/renderer'
  autoload :Resource,    'trinity/core/resource'
  autoload :Server,      'trinity/core/server'
  autoload :Theme,       'trinity/core/theme'
  autoload :Widget,      'trinity/core/widget'
end

require 'trinity/theme/data'
require 'trinity/admin'
require 'trinity/analytics'
require 'trinity/bitcache'
