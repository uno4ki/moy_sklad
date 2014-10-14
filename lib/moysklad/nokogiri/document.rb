require 'active_support/concern'

module Nokogiri::XML
  module AttributeCheck
    extend ActiveSupport::Concern

    included do
      def create_element_with_attrcheck(name, *args, &block)
        return create_element_without_attrcheck(name, nil, &block) if args[0].is_a?(::Moysklad::Client::Attribute::MissingAttr)
        return create_element_without_attrcheck(name, *args, &block) if !args[0].is_a?(Hash)

        args[0].delete_if { |k, v| v.is_a?(::Moysklad::Client::Attribute::MissingAttr) }

        create_element_without_attrcheck(name, *args, &block)
      end

      alias_method_chain :create_element, :attrcheck
    end
  end

  Nokogiri::XML::Document.send(:include, AttributeCheck)
end
