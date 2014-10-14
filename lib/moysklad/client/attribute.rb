# Placeholder class used by Nokogiri for create "clean" xml
# requests.

module Moysklad::Client
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
          Moysklad::Client::Attribute::MissingAttr.new
        end
      else
        super
      end
    end
  end

  ActiveResource::Base.send(:include, MissingAttrHandler)
end
