module MoySklad::Models
  class Company < MoySklad::Client::Base
    def initialize(*args)
      super(*args)

      create_nested_resource(:contact)
      create_nested_resource(:requisite)
      create_nested_resource(:tags)
      create_nested_collection(:contactPerson)
      requisite.create_nested_resource(:bankAccount)
    end

    def add_contact(options)
      self.contactPerson << create_and_load_resource('contactPerson', options)
    end
  end
end
