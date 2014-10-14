# Just a copy of "load" method from ActiveResouce with one modification:
# all nested resources now loaded as Hash elements instead of Array, object UUID (which is really unique)
# used as key
#
# You can do:
#  obj = Moysklad::Models::Model.find("some-uuid")
#  obj.attr["attr-uuid"].value = "foo"
#
# Instead of:
#  obj.attr.each do { |a|
#   if a.uuid = "attr-uuid"
#    a.value = "foo"
#   end
#  }
#
# NB: Nested object W/O uuid stored with 'nil' key and probably this can be a problem !

module ActiveResource
  class Base

    def load(attributes, remove_root = false, persisted = false)
      raise ArgumentError, "expected an attributes Hash, got #{attributes.inspect}" unless attributes.is_a?(Hash)
      @prefix_options, attributes = split_options(attributes)

      if attributes.keys.size == 1
        remove_root = self.class.element_name == attributes.keys.first.to_s
      end

      attributes = ActiveResource::Formats.remove_root(attributes) if remove_root

      attributes.each do |key, value|
        @attributes[key.to_s] =
          case value
            when Array
              resource = nil
              ### This is the magic
              Hash[value.collect do |attrs|
                if attrs.is_a?(Hash)
                  resource ||= find_or_create_resource_for_collection(key)
                  r = resource.new(attrs, persisted)
                  [r.uuid, r]
                else
                  [nil, attrs.duplicable? ? attrs.dup : attrs]
                end
              end]
              ### End of magic
            when Hash
              resource = find_or_create_resource_for(key)
              resource.new(value, persisted)
            else
              value.duplicable? ? value.dup : value
          end
      end
      self
    end
  end

end
