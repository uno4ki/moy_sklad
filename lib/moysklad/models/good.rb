module Moysklad::Models
  class Good < Moysklad::Client::Base

    def setSalePrice(type, value)
      create_nested_collection(:salePrices)

      v = self.salePrices.get_attribute(:price, :priceTypeUuid, type)
      if v.nil?
        self.salePrices.price << create_and_load_resource("Price", {
                              currencyUuid: Moysklad.currency, priceTypeUuid: type, value: value.to_f * 100
                            })
      else
        v.value = value.to_f * 100
      end
    end

    def getSalePrice(uuid)
      create_nested_collection(:salePrices)
      self.salePrices.get_attribute(:price, :priceTypeUuid, uuid)
    end
  end
end
