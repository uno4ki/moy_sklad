module MoySklad::Model
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

      # We're always have one person
      if to_a(:contactPerson).empty?
        contactPerson << create_and_load_resource('contactPerson', options)
      else
        to_a(:contactPerson)[0].load(options)
      end
    end
  end
end
