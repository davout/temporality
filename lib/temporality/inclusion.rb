module Temporality
  class Inclusion < ValidationStrategy

    def validate
      parent = @model.send(@assoc)

      if parent && (parent.starts_on > @model.starts_on || parent.ends_on < @model.ends_on)
        raise Temporality::Violation.new("Record of class #{self.class} is not temporally included in parent of class #{parent.class}, [#{@model.starts_on} - #{@model.ends_on}] is not included in [#{parent.starts_on} - #{parent.ends_on}]")
      end
    end

  end
end

