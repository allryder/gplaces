module Gplaces
  class Error < StandardError
  end

  class RequestDeniedError < Error; end
  class InvalidRequestError < Error; end

end