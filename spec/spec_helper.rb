require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
])

SimpleCov.start do
  add_filter '/spec/'
end

require(File.expand_path('../../lib/temporal', __FILE__))

