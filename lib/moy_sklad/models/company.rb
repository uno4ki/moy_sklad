module MoySklad::Models
  class Company < MoySklad::Client::Base
    def initialize(*args)
      super(*args)
      create_nested_resource(:contact)
      create_nested_resource(:tags)
    end
  end
end