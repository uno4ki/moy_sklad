module Moysklad::Models
  class Good < Moysklad::Client::Base

    def setSalePrice(type, value)
      create_nested_collection(:salePrices)

      v = self.salePrices.get_attribute(:price, :priceTypeUuid, type)
      if v.nil?
        self.salePrices.price[type] = create_and_load_resource("Price", {
                              currencyUuid: Moysklad.currency, priceTypeUuid: type, value: value * 100
                            })
      else
        v.value = value * 100
      end
    end

    def getSalePrice(uuid)
      create_nested_collection(:salePrices)
      (self.salePrices.get_attribute(:price, :priceTypeUuid, uuid).value.to_f / 100).round(2)
    end

    def setAttribute(info, value)
      v = get_attribute(:attribute, :metadataUuid, info[:uuid])
      if v.nil?
        data = {metadataUuid: info[:uuid]}
        data["value#{info[:type].to_s.capitalize}".to_sym] = value
        self.attribute[info[:uuid]] = create_and_load_resource("Attribute", data)
      else
        v.send("value#{info[:type].to_s.capitalize}=".to_sym, value)
      end
    end

    def getAttribute(uuid)
      get_attribute(:attribute, :metadataUuid, uuid)
    end
  end
end
