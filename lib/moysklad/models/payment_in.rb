module Moysklad::Models
  class PaymentIn < Moysklad::Client::Base
    def initialize(*args)
      super(*args)
      create_nested_collection(:attribute)
      create_nested_resource(:sum)
    end
  end
end
