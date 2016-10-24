module Temporality
  class ValidationStrategy

    def initialize(model, assoc)
      @model = model
      @assoc = assoc
    end


    protected

    def inverse
      raise "Unable to validate temporality overlap for #{@model.class} without inverse for association '#{@assoc}'" unless inverse_name
      @model.send(@assoc).send(inverse_name)
    end

    def inverse_name
      @model.class.reflect_on_association(@assoc).send(:inverse_name)
    end

  end
end

