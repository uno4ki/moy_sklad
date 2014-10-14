module Moysklad::Models
  class Good < Moysklad::Client::Base

    # Sale price have two uuids, one as normal id and second as type (crazy shit)
    # !!! Here we're use TYPE, not id !!!
    def setSalePrice(type, value)
      create_nested_collection(:salePrices)

      self.salePrices.create_nested_resource(:price)

      v = getSalePrice(type)
      if v
        v.value = value * 100
        return
      end

      # No luck, create one
      self.salePrices.price[type] = create_and_load_resource("Price", {
                              currencyUuid: Moysklad.currency, priceTypeUuid: type, value: value * 100
                            })
    end

    def getSalePrice(type)
      self.salePrices.price.each_value do |v|
        return v if v.priceTypeUuid == type
      end
      nil
    end
  end
end
