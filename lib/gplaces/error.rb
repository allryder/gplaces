module Gplaces
  class Error < StandardError; end
  class RequestDeniedError < Error; end
  class InvalidRequestError < Error; end
  class NotFoundError < Error; end
end
