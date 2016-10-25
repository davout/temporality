module Temporality
  module Transaction

    QUEUE = :deferred_temporality_constraints

    def transaction(*args, &block)
      raise RuntimeError.new("There already is a currently active temporality transaction") if active_transaction?

      ActiveRecord::Base.transaction(*args) do
        begin
          init_queue
          block.call
          process_queue
        ensure
          cleanup_queue
        end
      end
    end

    def defer(key, &block)
      Thread.current[QUEUE][key] = block
    end

    def active_transaction?
      !!Thread.current[QUEUE]
    end

    def process_queue
      Thread.current[QUEUE].values.each(&:call)
    end

    def init_queue
      Thread.current[QUEUE] = Hash.new
    end

    def cleanup_queue
      Thread.current[QUEUE] = nil
    end

  end
end

