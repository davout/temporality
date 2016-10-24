require 'temporality/validation_strategy'

module Temporality
  class Overlap < ValidationStrategy

    def validate
      overlapping = inverse.intersecting(@model)

      if @model.id
        overlapping = overlapping.where('id <> ?', @model.id)
      end

      raise Temporality::Violation.new(error_message) if overlapping.exists?
    end

    def error_message
      "Found overlapping records for range [#{@model.starts_on} - #{@model.ends_on}]"
    end

  end
end

