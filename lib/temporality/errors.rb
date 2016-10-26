module Temporality
  class Violation < RuntimeError; end
  class AutoCloseError < Violation; end
  class NoTransactionError < Violation; end
end

