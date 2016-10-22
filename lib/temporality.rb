require 'date'

require 'temporality/version'

require 'temporality/slice_collection'

require 'temporality/validation'
require 'temporality/default_boundary_values'
require 'temporality/attribute_overrides'
require 'temporality/associations'

require 'temporality/migration_helpers'

module Temporality

  # Used when no start date is defined
  PAST_INFINITY = Date.new(1500, 1, 1)

  # Used when no end date is defined
  FUTURE_INFINITY = Date.new(5000, 1, 1)

  PREPENDS  = [ AttributeOverrides, Validation ]
  EXTENDS   = [ Associations ]
  INCLUDES  = [ DefaultBoundaryValues ]

  def self.included(base)
    PREPENDS.each { |mod| base.prepend(mod) }
    EXTENDS.each  { |mod| base.extend(mod) }
    INCLUDES.each { |mod| base.include(mod) }
  end

end

if Object.const_defined?(:ActiveRecord)
  ActiveRecord::Migration.send(:include, Temporality::MigrationHelpers)
end

