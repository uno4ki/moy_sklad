module MoySklad::Models
  class Good < MoySklad::Client::Base
    def set_sale_price(type, value)
      create_nested_resource(:salePrices)

      v = self.salePrices.get_attribute(:price, :priceTypeUuid, type)
      if v.nil?
        create_price(type,value)
      else
        v.value = value.to_f * 100
      end
    end

    def get_sale_price(uuid)
      create_nested_resource(:salePrices)
      self.salePrices.get_attribute(:price, :priceTypeUuid, uuid)
    end

    private

    def create_price(type, value)
      options = { currencyUuid: MoySklad.configuration.currency,
                  priceTypeUuid: type, value: value.to_f * 100 }
      p = create_and_load_resource('Price', options)
      if self.salePrices.price.is_a?(MoySklad::Client::Attribute::MissingAttr)
        self.salePrices.price = [p]
      else
        self.salePrices.price << p
      end
    end
  end
end
