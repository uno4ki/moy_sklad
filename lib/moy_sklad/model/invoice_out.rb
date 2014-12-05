module MoySklad::Model
  class InvoiceOut < MoySklad::Client::Base
    def initialize(*args)
      super(*args)
      create_nested_resource(:sum)
      create_nested_collection(:invoicePosition)
    end
  end
end
