module MoySklad::Model
  class Warehouse < MoySklad::Client::Base
    def initialize(*args)
      super(*args)
      create_nested_collection(:slots)
    end

    def items(mode = 'POSITIVE_ONLY')
      StockTo.find(:all, params: {storeUuid: self.uuid, stockMode: mode})
    end
  end
end
