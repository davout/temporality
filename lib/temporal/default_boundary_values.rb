module Temporal
  module DefaultBoundaryValues

    def self.included(base)
      base.after_initialize :set_time_boundaries_defaults

      def set_time_boundaries_defaults
        self.starts_on = starts_on
        self.ends_on = ends_on
      end
    end

  end
end

