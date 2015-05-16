module MoySklad::Model
  class Good < MoySklad::Client::Base
    def set_sale_price(type, value, currency)
      create_nested_resource(:salePrices)

      v = self.salePrices.find_object(:price, :priceTypeUuid, type)
      if v.nil?
        create_price(type, value, currency)
      else
        v.value = value.to_i
      end
    end

    def get_sale_price(uuid)
      create_nested_resource(:salePrices)
      self.salePrices.find_object(:price, :priceTypeUuid, uuid)
    end

    private

    def create_price(type, value, currency)
      options = { currencyUuid: currency, priceTypeUuid: type, value: value.to_i }
      p = create_and_load_resource('Price', options)
      if self.salePrices.price.is_a?(MoySklad::Client::Attribute::MissingAttr)
        self.salePrices.price = [p]
      else
        self.salePrices.price << p
      end
    end
  end
end
