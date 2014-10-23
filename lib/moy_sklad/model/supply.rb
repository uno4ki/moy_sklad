module MoySklad::Model
  class Supply < MoySklad::Client::Base
    def initialize(*args)
      super(*args)
      create_nested_collection(:attribute)
      create_nested_resource(:sum)
      create_nested_collection(:shipmentIn)
    end

    def add_item(id, options)
      item = create_and_load_resource("shipmentIn",
                                      { goodUuid: id }.merge!(options))
      if to_a(:shipmentIn).empty?
        self.shipmentIn = [item]
      else
        self.shipmentIn << item
      end
    end
  end
end
