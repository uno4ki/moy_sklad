# Nested resources management

module ActiveResource
  class Base

    # Nested object finder by type uuid + object uuid.
    #
    # MS data model have arrays which contains objects where each object have a special "type"
    # uuid and object uuid. Type + Object uuids are PK for the object.
    #
    # @attr name [Symbol] attribute name
    # @attr type [String] "type" uuid
    # @attr key  [String] "object" uuid
    #
    def find_object(name, type, key)
      return nil if self.send(name).is_a?(MoySklad::Client::Attribute::MissingAttr)

      create_nested_resource(name)

      # Convert single attr to array
      self.send("#{name}=", [self.send(name)]) unless self.send(name).is_a?(Array)

      self.send(name).each do |v|
        return v if v.send(type) == key
      end

      nil
    end

    private

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

    def create_nested_collection_or_resource(name, collection = true)
      name = name.to_s
      if !known_attributes.include?(name)
        self.known_attributes << name
        self.attributes[name] = collection ? [] : create_and_load_resource(name)
      end
    end
  end
end
