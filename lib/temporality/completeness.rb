require 'temporality/validation_strategy'

module Temporality
  class Completeness < ValidationStrategy

    def validate
      days = @model.day_count + (inverse.where('id <> ?', @model.id || -1).map(&:day_count).inject(&:+) || 0)
      parent_days = @model.send(@assoc).day_count

      raise Temporality::Violation.new(error_message) unless (parent_days == days)
    end

    def error_message
      "#{@model.send(@assoc).class} record must have a temporally complete children collection for assocation #{inverse_name}"
    end

    # TODO : Check if in transaction ActiveRecord::Base.connection.open_transactions

  end
end

