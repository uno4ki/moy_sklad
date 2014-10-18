module MoySklad::Models
  class Good < MoySklad::Client::Base

    def setSalePrice(type, value)
      create_nested_resource(:salePrices)

      v = self.salePrices.get_attribute(:price, :priceTypeUuid, type)
      if v.nil?
        p = create_and_load_resource("Price", { currencyUuid: MoySklad.currency, priceTypeUuid: type, value: value.to_f * 100 })
        if self.salePrices.price.is_a?(MoySklad::Client::Attribute::MissingAttr)
          self.salePrices.price = [p]
        else
          self.salePrices.price << p
        end
      else
        v.value = value.to_f * 100
      end
    end

    def getSalePrice(uuid)
      create_nested_resource(:salePrices)
      self.salePrices.get_attribute(:price, :priceTypeUuid, uuid)
    end
  end
end
