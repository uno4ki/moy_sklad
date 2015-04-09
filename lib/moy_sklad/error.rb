module MoySklad
  class BaseError < RuntimeError; end
  class BadApiResponse < MoySklad::BaseError; end
  class EmptyCollection < MoySklad::BaseError; end
end
