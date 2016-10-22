module Temporal
  module Associations

    # TODO : Use class-inheritable instance variables

    def belongs_to(*args, &block)
      @temporality ||= {}
      assoc_name = args.first

      if args.last.is_a?(Hash)
        @temporality[assoc_name] = args.last.delete(:temporality)
      end

      super(*args, &block)
    end

  end
end

