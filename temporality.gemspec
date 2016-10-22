# coding: utf-8

lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'temporality/version'

Gem::Specification.new do |s|
  s.name        = 'temporality'
  s.version     = Temporality::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['David FRANCOIS']
  s.email       = ['david@paygun.fr']
  s.homepage    = 'https://paygun.fr'
  s.summary     = 'Make records temporal'
  s.description = 'Give records the ability to validate temporal constraints on themselves and associations'
  s.licenses    = ['MIT']

  s.required_rubygems_version = '>= 1.3.6'

  s.add_development_dependency 'rspec',     '~> 3.1'
  s.add_development_dependency 'rake',      '~> 10.3'
  s.add_development_dependency 'yard',      '~> 0.8'
  s.add_development_dependency 'redcarpet', '~> 3.1'
  s.add_development_dependency 'simplecov', '~> 0.9'
  s.add_development_dependency 'coveralls', '~> 0.7'
  s.add_development_dependency 'activerecord'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'byebug'

  s.files = Dir.glob('lib/**/*') + %w(LICENSE README.md)

  s.require_path = 'lib'
end

