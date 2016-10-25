require 'temporality/validation_strategy'

module Temporality
  class Completeness < ValidationStrategy

    def validate
      if Temporality.active_transaction?
        Temporality.defer(defer_key) { perform_validation }
      else
        perform_validation
      end
    end

    def perform_validation
      days = @model.day_count + (inverse.where('id <> ?', @model.id || -1).map(&:day_count).inject(&:+) || 0)
      parent_days = @model.send(@assoc).day_count
      raise Temporality::Violation.new(error_message) unless (parent_days == days)
    end

    def defer_key
      parent = @model.send(@assoc)
      "#{parent.class.name}_#{parent.id}_#{inverse_name}"
    end

    def error_message
      "#{@model.send(@assoc).class} record must have a temporally complete children collection for assocation #{inverse_name}"
    end

  end
end

