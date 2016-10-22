require 'simplecov'
require 'coveralls'
require 'fileutils'
require 'byebug'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
])

SimpleCov.start do
  add_filter '/spec/'
end

require(File.expand_path('../../lib/temporality', __FILE__))

require 'active_record'
require 'sqlite3'

FileUtils.rm('test.sqlite3')
db = { adapter: 'sqlite3', database: 'test.sqlite3' }
ActiveRecord::Base.establish_connection(db)

schema_init = [
  'CREATE TABLE dummies (id INTEGER AUTO_INCREMENT, starts_on DATE NOT NULL, ends_on DATE NOT NULL, PRIMARY KEY(id))',
  'CREATE TABLE people (id INTEGER AUTO_INCREMENT, starts_on DATE NOT NULL, ends_on DATE NOT NULL, PRIMARY KEY(id))',
  'CREATE TABLE dogs (id INTEGER AUTO_INCREMENT, person_id INTEGER NOT NULL, starts_on DATE NOT NULL, ends_on DATE NOT NULL, PRIMARY KEY(id))'
]

schema_init.each { |query| ActiveRecord::Base.connection.execute(query) }

class Dummy < ActiveRecord::Base
  include Temporality
end

class Person < ActiveRecord::Base
  include Temporality
  has_many :dogs
end

class Dog < ActiveRecord::Base
  include Temporality
  belongs_to :person, temporality: { inclusion: true }
end

