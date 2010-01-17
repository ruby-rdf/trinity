#!/usr/bin/env ruby -rubygems
# -*- encoding: utf-8 -*-

GEMSPEC = Gem::Specification.new do |gem|
  gem.version            = File.read('VERSION').chomp
  gem.date               = File.mtime('VERSION').strftime('%Y-%m-%d')

  gem.name               = 'trinity'
  gem.homepage           = 'http://trinity.datagraph.org/'
  gem.license            = 'Public Domain' if gem.respond_to?(:license=)
  gem.summary            = 'A minimalistic web framework for publishing Linked Data.'
  gem.description        = 'Trinity is a minimalistic web framework for publishing Linked Data.'
  gem.rubyforge_project  = nil

  gem.authors            = ['Arto Bendiken', 'Ben Lavender', 'Josh Huckabee']
  gem.email              = 'arto.bendiken@gmail.com'

  gem.platform           = Gem::Platform::RUBY
  gem.files              = %w(AUTHORS README UNLICENSE VERSION etc/localhost.nt) + Dir.glob('lib/**/*.rb')
  gem.bindir             = %q(bin)
  gem.executables        = %w(trinity)
  gem.default_executable = gem.executables.first
  gem.require_paths      = %w(lib)
  gem.extensions         = %w()
  gem.test_files         = %w()
  gem.has_rdoc           = false

  gem.required_ruby_version      = '>= 1.8.2'
  gem.requirements               = []
  gem.add_development_dependency 'rspec',       '>= 1.2.9'
  gem.add_development_dependency 'yard' ,       '>= 0.5.2'
  gem.add_runtime_dependency     'rdf',         '>= 0.0.8'
  gem.add_runtime_dependency     'addressable', '>= 2.1.1'
  gem.add_runtime_dependency     'mime-types',  '>= 1.16'
  gem.add_runtime_dependency     'rack',        '>= 1.1.0'
  gem.add_runtime_dependency     'thin',        '>= 1.2.5'
  gem.add_runtime_dependency     'markaby',     '>= 0.5'
  gem.post_install_message       = nil
end
