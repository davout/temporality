module Temporality

  # = Temporal associations
  #
  # This module overrides +ActiveRecord::Base.belongs_to+ with the ability to 
  # specifiy temporality options on the association.
  #
  # == Inverse associations
  #
  # It is necessary that ActiveRecord knows the inverse association on the
  # +has_many+ side. If it isn't inferred automatically you must specify it
  # using the +:inverse_of+ option on the +has_many+ declaration.
  #
  # @todo Use class-inheritable instance variables
  #
  module Associations

    # The default temporality options
    DEFAULTS = { inclusion: true, completeness: false, prevent_overlap: false, auto_close: false }.freeze

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

          @temporality[assoc_name] = with_implied_options(DEFAULTS.merge(opts))
        end
      end

      super(*args, &block)
    end


    private

    #
    # Sets options implied by other options as follows:
    #
    #  - +:auto_close+ implies +:completeness+
    #  - +:completeness+ implies +:prevent_overlap+
    #  - +:completeness+ implies +:inclusion+
    #
    # @param opts [Hash] The options hash
    # @return [Hash] The options with implied options set
    #
    def with_implied_options(opts)
      res = opts.dup
      res[:completeness]    ||= res[:auto_close]
      res[:prevent_overlap] ||= res[:completeness]
      res[:inclusion]       ||= res[:completeness]
      res
    end

  end
end

