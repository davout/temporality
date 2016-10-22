module Temporality

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
    # Floors the parameter to `Temporality::PAST_INFINITY`
    #
    def floor_to_temporal_infinity(d)
      [d, Temporality::PAST_INFINITY].compact.max
    end

    #
    # Ceils the parameter to `Temporality::FUTURE_INFINITY`
    #
    def ceil_to_temporal_infinity(d)
      [d, Temporality::FUTURE_INFINITY].compact.min
    end



  end

end

