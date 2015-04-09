# Resources collection handler

require 'active_resource'
require 'active_support/core_ext/hash/conversions'
require 'active_support/core_ext/hash/indifferent_access'

module MoySklad::Client
  class Collection < ActiveResource::Collection
    attr_reader :metadata

    def initialize(data)
      fail MoySklad::BadApiResponse unless data
      fail MoySklad::BadApiResponse unless data[:data]
      fail MoySklad::EmptyCollection unless data[:data]['collection']

      @elements = data[:data]['collection'].delete(data[:object])
      @elements = [@elements] if @elements.is_a?(Hash)
      @metadata = HashWithIndifferentAccess.new(data[:data]['collection'])

      @elements ||= []

      # Fix keys
      [:total, :start, :count].each do |k|
        @metadata[k] = @metadata[k].to_i if @metadata.has_key?(k)
      end
    end
  end
end
