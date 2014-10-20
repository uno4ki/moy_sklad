module MoySklad::Model
  class CustomerOrder < MoySklad::Client::Base

    def initialize(*args)
      super(*args)
      create_nested_collection(:customerOrderPosition)
      create_nested_collection(:attribute)
      create_nested_resource(:sum)
    end

    def addItem(id, options = {})
      item = create_and_load_resource("CustomerOrderPosition",
                                      { goodUuid: id }.merge!(options))
      if to_a(:customerOrderPosition).empty?
        self.customerOrderPosition = [item]
      else
        self.customerOrderPosition << item
      end
    end
  end
end
