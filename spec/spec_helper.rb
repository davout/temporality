require 'simplecov'
require 'coveralls'
require 'byebug'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
])

SimpleCov.start do
  add_filter '/spec/'
end

require 'active_record'

require(File.expand_path('../../lib/temporality', __FILE__))

require 'support/schema'
require 'support/models'

