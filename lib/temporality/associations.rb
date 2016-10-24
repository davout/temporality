module Temporality
  module Associations

    # TODO : Use class-inheritable instance variables

    DEFAULTS = { inclusion: true, completeness: false, prevent_overlap: false, auto_close: false }

    def belongs_to(*args, &block)
      @temporality ||= {}
      assoc_name = args.first

      if args.last.is_a?(Hash)
        if opts = args.last.delete(:temporality)
          opts.keys.each do |key|
            unless DEFAULTS.keys.include?(key)
              raise "Unknown option '#{key}', valid options are #{DEFAULTS.keys.map(&:to_s).join(', ')}"
            end
          end

          @temporality[assoc_name] = DEFAULTS.merge(opts)
        end
      end

      super(*args, &block)
    end

  end
end

