module Temporality
  module Scopes

    def intersecting(time_span)
      where('starts_on <= ?', time_span.ends_on).where('ends_on >= ?', time_span.starts_on)
    end

  end
end

