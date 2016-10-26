require 'temporality/validation_strategy'

module Temporality
  class AutoClose < ValidationStrategy

    def call
      prev = nil

      if @model.id
        prev = inverse.order('starts_on ASC').where('id <> ?', @model.id).last
      else
        prev = inverse.order('starts_on ASC').last
      end

      if prev
        if prev.starts_on >= @model.starts_on
        raise Temporality::AutoCloseError.new("Can't auto-close a previous sibling with a fully overlapping record")
        end

        if prev.ends_on != Temporality::FUTURE_INFINITY
          raise Temporality::AutoCloseError.new("Can't auto-close previous record if it's end date is finite")
        end
      end

      if prev
        if Temporality.active_transaction?
          prev.ends_on = @model.starts_on - 1
          prev.save
        else
          raise Temporality::NoTransactionError.new("Auto-closing previous records requires a Temporality transaction")
        end
      end
    end

  end
end

