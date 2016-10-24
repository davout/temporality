module Temporality
  module DayCount

    def day_count
      (ends_on - starts_on).to_i
    end

  end
end

