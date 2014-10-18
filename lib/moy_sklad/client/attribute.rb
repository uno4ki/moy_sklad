# Placeholder class used by Nokogiri for create "clean" xml
# requests.

module MoySklad::Client
  module Attribute
    class MissingAttr
      def method_missing(meth, *args)
        MissingAttr.new
      end
    end
  end

  # Include in baseclass because we need this in ALL subclasses
  # (also in autocreated by AR)
  module MissingAttrHandler
    def method_missing(meth, *args)
      if meth[-1] != '='
        begin
          super
        rescue
          MoySklad::Client::Attribute::MissingAttr.new
        end
      else
        super
      end
    end
  end

  module CustomAttrBehavior

    # Attributes array is widely used in all MS data objects. It handle custom attributes
    # for each object. For make life easier we're use get/set_attribute functions.

    # Get attrubute from the "attributes" array of the object.
    #
    # @attr info  [Hash] attribute info hash, should have keys: {:uuid, :value}
    # @attr value [Object] value to set
    #
    def set_attribute(info, value)

      raise ArgumentError, "Argument should be hash with at least [:uuid, :value] keys" unless info.is_a?(Hash)
      raise ArgumentError, "You must provide keys: [:uuid, :value]" unless info.has_key?(:uuid) || info.has_key?(:value)

      v = find_object(:attribute, :metadataUuid, info[:uuid])
      if v.nil?
        data = { metadataUuid: info[:uuid] }
        data[info[:value]] = value
        a = create_and_load_resource('Attribute', data)
        if self.to_a(:attribute).empty?
          self.attribute = [a]
        else
          self.attribute << a
        end
      else
        v.send("#{info[:value]}=".to_sym, value)
      end

    end

    # Set attribute in "attributes" array of the object.
    #
    # @attr info [Hash/String] hash with at least [:uuid] key or String with uuid.
    #                          if hash containts [:value] key then value will be returned
    #                          instead of plceholder object.
    def get_attribute(info)

      uuid = info if info.is_a?(String) && (info.length == 36)
      uuid = info[:uuid] if info.is_a?(Hash) && (!info[:uuid].nil? && info[:uuid].length == 36)
      raise ArgumentError, "Argument should be uuid string or hash with [:uuid] key" if uuid.nil?

      a = find_object(:attribute, :metadataUuid, uuid)

      if info.is_a?(Hash) && info.has_key?(:value)
        return a.send(info[:value]) if a.respond_to?(info[:value])
        nil
      else
        a
      end
    end

    # Get object attribute as array.
    # object.to_a(:some_type) will always return array and of course it can be empty.
    def to_a(type)

      value = self.send(type)
      return [] if value.nil? || value.is_a?(MoySklad::Client::Attribute::MissingAttr)

      # Convert
      self.send("#{type}=", [value]) unless value.is_a?(Array)
      self.send(type)
    end

  end

  ActiveResource::Base.send(:include, MissingAttrHandler)
  ActiveResource::Base.send(:include, CustomAttrBehavior)
end
