require 'date'

require 'temporality/version'

require 'temporality/slice_collection'
require 'temporality/errors'
require 'temporality/validation'
require 'temporality/default_boundary_values'
require 'temporality/attribute_overrides'
require 'temporality/associations'
require 'temporality/schema'
require 'temporality/scopes'
require 'temporality/day_count'
require 'temporality/transaction'

# = Temporality
#
# Root module for temporal functionality, include it in ActiveRecord classes
# to benefit from the temporality features.
#
# This functionality requires a +starts_on+ and +ends_on+ attribute pair defined
# on the models in which the module is included.
#
# == Example
#
# This will define three classes with temporality constraints. An employment
# contract will be required to be temporally within the bounds of the legal entity
# with which it is made. A contract will also be required to have a temporally
# complete set of compensation records.
#
#   class LegalEntity < ActiveRecord::Base
#     include Temporality
#     has_many :employment_contracts
#   end
#
#   class EmploymentContract < ActiveRecord::Base
#     include Temporality
#     has_many :compensations
#     belongs_to :legal_entity, temporality: {
#       inclusion: true,
#       auto_close: false,
#       completeness: false,
#       prevent_overlap: false
#     }
#   end
#
#   class Compensation < ActiveRecord::Base
#     include Temporality
#     belongs_to :employment_contract, temporality: {
#       inclusion: true,
#       auto_close: true,
#       completeness: true,
#       prevent_overlap: true
#     }
#   end
#
module Temporality

  extend Transaction

  # Used when no start date is defined
  PAST_INFINITY = Date.new(1500, 1, 1)

  # Used when no end date is defined
  FUTURE_INFINITY = Date.new(5000, 1, 1)

  # Prepended modules
  PREPENDS  = [ AttributeOverrides, Validation ]

  # Extensions to the included class
  EXTENDS   = [ Associations, Scopes ]

  # Inclusions for the included class
  INCLUDES  = [ DefaultBoundaryValues ]

  def self.included(base)
    PREPENDS.each { |mod| base.prepend(mod) }
    EXTENDS.each  { |mod| base.extend(mod) }
    INCLUDES.each { |mod| base.include(mod) }

    # TODO : On va peut-être pas l'inclure 50 fois ce truc...
    ActiveRecord::Base.send(:include, DayCount)
  end

end

