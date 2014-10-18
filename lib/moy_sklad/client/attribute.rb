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

  module CommonAttributeAccess
    def setAttribute(info, value)
      v = get_attribute(:attribute, :metadataUuid, info[:uuid])
      if v.nil?
        data = { metadataUuid: info[:uuid] }
        data[info[:value]] = value
        a = create_and_load_resource('Attribute', data)
        if self.getArray(:attribute).empty?
          self.attribute = [a]
        else
          self.attribute << a
        end
      else
        v.send("#{info[:value]}=".to_sym, value)
      end
    end

    def getAttribute(uuid)
      get_attribute(:attribute, :metadataUuid, uuid)
    end

    def getArray(type)
      value = self.send(type)
      return [] if value.nil? || value.is_a?(MoySklad::Client::Attribute::MissingAttr)

      # Convert
      self.send("#{type}=", [value]) unless value.is_a?(Array)
      self.send(type)
    end

  end

  ActiveResource::Base.send(:include, MissingAttrHandler)
  ActiveResource::Base.send(:include, CommonAttributeAccess)
end
