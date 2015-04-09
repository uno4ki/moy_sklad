module MoySklad
  class BaseError < RuntimeError; end
  class BadApiResponse < BaseError; end
  class EmptyCollection < BaseError; end
end
