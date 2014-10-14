
module ActiveResource
  class Base

    # Construct nested resource class and load with given attributes
    # NB: ALL nested classes should be created through this way.
    def create_and_load_resource(name, attributes = nil)
      res = find_or_create_resource_for(name).new
      res.load(attributes) if !attributes.nil?
      res
    end

    def create_nested_collection(name)
      create_nested_collection_or_resource(name)
    end

    def create_nested_resource(name)
      create_nested_collection_or_resource(name, false)
    end

    private

    def create_nested_collection_or_resource(name, collection = true)
      name = name.to_s
      if !known_attributes.include?(name)
        self.known_attributes << name
        self.attributes[name] = collection ? create_and_load_resource(name) : {}
      end

    end

  end
end
