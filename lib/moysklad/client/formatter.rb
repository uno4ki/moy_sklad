# Custom formatter
# Used only on retrive process. Submission encoder live in base.rb

require 'active_resource'
require 'active_support/core_ext/hash/conversions'

module Moysklad::Client
  class Formatter
    include ::ActiveResource::Formats::XmlFormat

    attr_accessor :element_name

    def decode(_data)
      data = Hash.from_xml(_data)

      if data.has_key?('collection')
        {data: data, object: element_name.downcase}
      else
        data
      end
    end
  end
end
