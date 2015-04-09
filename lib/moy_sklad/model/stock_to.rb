module MoySklad::Model
  class StockTo < MoySklad::Client::Base
    self.site = MoySklad.configuration.warehouse_url

    def initialize(*args)
      super(*args)
    end

    class << self
      def element_name
        "stockTO"
      end

      def collection_name
        ""
      end
    end
  end
end
