require 'temporal/version'
require 'temporal/validation'
require 'temporal/attribute_overrides'

module Temporal

  # Used when no start date is defined
  PAST_INFINITY = Date.new(1500, 1, 1)

  # Used when no end date is defined
  FUTURE_INFINITY = Date.new(5000, 1, 1)

  def included(base)
    [ Validation, AttributeOverrides ].each { |m| base.prepend(m) }
  end

end

