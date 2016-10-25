require 'temporality/violation'

require 'temporality/auto_close'
require 'temporality/completeness'
require 'temporality/overlap'
require 'temporality/inclusion'

module Temporality
  module Validation

     CONSTRAINTS = {
      inclusion:        Inclusion,
      prevent_overlap:  Overlap,
      completeness:     Completeness,
      auto_close:       AutoClose
    }

    DEFAULTS = { inclusion: true, completeness: false, prevent_overlap: false, auto_close: false }

    def valid?(*args, &block)
      validate_temporality_contraints!
      super(*args, &block)
    end


    private

    def validate_temporality_contraints!
      validate_bounds_order

      temporal_associations.each do |assoc, constraints|
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

