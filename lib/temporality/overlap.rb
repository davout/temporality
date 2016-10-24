require 'temporality/validation_strategy'

module Temporality
  class Overlap < ValidationStrategy

    def validate
      inverse = @model.class.reflect_on_association(@assoc).send(:inverse_name)
      raise "Unable to validate temporality overlap for #{@model.class} without inverse for association '#{@assoc}'" unless inverse

      overlapping = @model.send(@assoc).send(inverse).intersecting(@model)

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

