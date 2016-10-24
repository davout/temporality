# Creates the test schema

require 'fileutils'
require 'active_record'
require 'sqlite3'

FileUtils.rm('test.sqlite3') rescue nil
db = { adapter: 'sqlite3', database: 'test.sqlite3' }
ActiveRecord::Base.establish_connection(db)

ActiveRecord::Schema.define do
  create_table :dummies do |t|
    t.temporality
  end

  create_table :people do |t|
    t.temporality
  end

  create_table :dogs do |t|
    t.integer :person_id
    t.temporality
  end
end

