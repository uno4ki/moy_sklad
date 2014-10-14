# Resources collection handler

require 'active_resource'
require 'active_support/core_ext/hash/conversions'
require 'active_support/core_ext/hash/indifferent_access'

module Moysklad::Client
  class Collection < ActiveResource::Collection

    attr_reader :metadata

    def initialize(data)

      @elements = data[:data]['collection'].delete(data[:object])
      @elements = [@elements] if @elements.is_a?(Hash)
      @metadata = HashWithIndifferentAccess.new(data[:data]['collection'])

      # Fix keys
      [:total, :start, :count].each do |k|
        @metadata[k] = @metadata[k].to_i if @metadata.has_key?(k)
      end
    end
  end
end
