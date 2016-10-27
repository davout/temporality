module Temporality

  #
  # This module provides an override for the `build` method on an association
  # proxy in order to automatically set the temporal bounds on built children
  # unless these were explicitly provided.
  #
  module AssociationExtensions

    #
    # Override for `ActiveRecord::Relation#build` that provides automatic
    # values for the temporal bounds.
    #
    # @return [ActiveRecord::Base] The built model
    #
    def build(**kwargs, &block)
      with_default_bounds_scope(**kwargs) { super(**kwargs, &block) }
    end

    #
    # Override for `ActiveRecord::Relation#create` that provides automatic
    # values for the temporal bounds.
    #
    # @return [ActiveRecord::Base] The built model
    #
    def create(**kwargs, &block)
      with_default_bounds_scope(**kwargs) { super(**kwargs, &block) }
    end

    #
    # Override for `ActiveRecord::Relation#create!` that provides automatic
    # values for the temporal bounds.
    #
    # @return [ActiveRecord::Base] The built model
    #
    def create!(**kwargs, &block)
      with_default_bounds_scope(**kwargs) { super(**kwargs, &block) }
    end

    #
    # Yields to the given block with a scope defining default values for the
    # temporal bounds.
    #
    def with_default_bounds_scope(**kwargs)
      return unless block_given?

      owner = proxy_association.owner
      klass = proxy_association.klass

      starts_on = kwargs[:starts_on]
      ends_on   = kwargs[:ends_on]

      if temporal_compatible_association?(owner, klass.new)
        last_child  = scope.order('ends_on ASC').last

        ends_on ||= owner.ends_on

        if scope.count.zero?
          starts_on ||= owner.starts_on
        elsif last_child.ends_on < owner.ends_on
          starts_on ||= last_child.ends_on + 1
        end
      end

      starts_on ||= Temporality::PAST_INFINITY
      ends_on   ||= Temporality::FUTURE_INFINITY

      where(starts_on: starts_on).where(ends_on: ends_on).scoping { yield }
    end


    private

    #
    # Returns `true` if the association parent and children have temporal bounds
    #
    # @return [Boolean]
    #
    def temporal_compatible_association?(*models)
      models.all? { |m| m.respond_to?(:starts_on) && m.respond_to?(:ends_on) }
    end

  end
end

