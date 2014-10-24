module MoySklad::Model
  class Demand < MoySklad::Client::Base
    def initialize(*args)
      super(*args)
      create_nested_collection(:attribute)
      create_nested_resource(:sum)
      create_nested_collection(:shipmentOut)
    end

    def add_item(id, options)
      item = create_and_load_resource("shipmentOut",
                                      { goodUuid: id }.merge!(options))
      if to_a(:shipmentOut).empty?
        self.shipmentOut = [item]
      else
        self.shipmentOut << item
      end
    end
  end
end
