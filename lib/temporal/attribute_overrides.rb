module Temporal

  module AttributeOverrides

    def starts_on
      floor_to_temporal_infinity(super)
    end

    def ends_on
      ceil_to_temporal_infinity(super)
    end

    def starts_on=(d)
      super(floor_to_temporal_infinity(d))
    end

    def ends_on=(d)
      super(ceil_to_temporal_infinity(d))
    end

    private

    #
    # Floors the parameter to `Temporal::PAST_INFINITY`
    #
    def floor_to_temporal_infinity(d)
      [d, Temporal::PAST_INFINITY].compact.max
    end

    #
    # Ceils the parameter to `Temporal::FUTURE_INFINITY`
    #
    def ceil_to_temporal_infinity(d)
      [d, Temporal::FUTURE_INFINITY].compact.min
    end



  end

end

