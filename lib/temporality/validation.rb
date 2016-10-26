require 'temporality/auto_close'
require 'temporality/completeness'
require 'temporality/overlap'
require 'temporality/inclusion'

module Temporality
  module Validation

    CONSTRAINTS = {
      inclusion:        Inclusion,
      prevent_overlap:  Overlap,
      completeness:     Completeness
    }

    DEFAULTS = { inclusion: true, completeness: false, prevent_overlap: false, auto_close: false }

    def valid?(*args, &block)
      validate_temporality_contraints!
      super(*args, &block)
    end


    private

    def validate_temporality_contraints!
      validate_bounds_order

      temporal_associations.each do |assoc, constrs|
        constraints = constrs.dup

        if constraints.delete(:auto_close)
          AutoClose.new(self, assoc).call
        end

        constraints.map { |constraint, enabled| constraint if enabled }.compact.each do |constraint|
          validate_constraint(assoc, constraint)
        end
      end
    end

    def validate_constraint(assoc, constraint_name)
      CONSTRAINTS[constraint_name].new(self, assoc).validate
    end

    def validate_bounds_order
      if starts_on > ends_on
        raise Temporality::Violation.new("Start date is after end date [#{starts_on} - #{ends_on}]")
      end
    end

    def temporal_associations
      self.class.instance_variable_get(:@temporality) || {}
    end

  end
end

