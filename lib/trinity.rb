require 'addressable/uri'
require 'mime/types'
require 'rack'
require 'rdf'
require 'rdf/ntriples'
require 'trinity/version'

module Trinity
  autoload :Application, 'trinity/application'
  autoload :Handler,     'trinity/handler'
  autoload :Renderer,    'trinity/renderer'
  autoload :Resource,    'trinity/resource'
  autoload :Server,      'trinity/server'
  autoload :Widget,      'trinity/widget'
end
