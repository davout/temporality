require 'temporality/violation'

module Temporality
  module Validation

    def valid?(*args, &block)
      validate_temporality_contraints!
      super(*args, &block)
    end


    private

    def validate_temporality_contraints!
      validate_bounds_order!

      temporal_associations.each do |assoc, constraints|
        validate_inclusion_in_parents!(assoc, constraints)
      end
    end

    def validate_bounds_order!
      if starts_on > ends_on
        raise Temporality::Violation.new("Start date is after end date [#{starts_on} - #{ends_on}]")
      end
    end

    def validate_inclusion_in_parents!(assoc, constraints)
      if constraints[:inclusion]
        parent = send(assoc)

        if parent && (parent.starts_on > starts_on || parent.ends_on < ends_on)
          raise Temporality::Violation.new("Record of class #{self.class} is not temporally included in parent of class #{parent.class}, [#{starts_on} - #{ends_on}] is not included in [#{parent.starts_on} - #{parent.ends_on}]")
        end
      end
    end

    def temporal_associations
      self.class.instance_variable_get(:@temporality) || {}
    end

  end
end

