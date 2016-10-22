require 'date'

require 'temporal/version'
require 'temporal/validation'
require 'temporal/default_boundary_values'
require 'temporal/attribute_overrides'
require 'temporal/associations'

# TODO : Raise exception if end_date is before start_date
# TODO : Migration helpers

module Temporal

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

