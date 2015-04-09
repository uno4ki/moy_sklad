# Resources collection handler

require 'active_resource'
require 'active_support/core_ext/hash/conversions'
require 'active_support/core_ext/hash/indifferent_access'

module MoySklad::Client
  if ActiveResource::VERSION::STRING < '4.0.0'
    class Collection
      include Enumerable

      delegate :collect, :each, :length, :to => :to_a

      attr_accessor :elements

      def to_a
        @elements
      end

      def collect!
        return @elements unless block_given?
        set = []
        each { |o| set << yield(o) }
        @elements = set
        self
      end

      alias map! collect!
    end
  else
    class Collection < ActiveResource::Collection
    end
  end

  class Collection
    attr_reader :metadata

    def initialize(data)
      fail MoySklad::BadApiResponseError unless data
      fail MoySklad::BadApiResponseError unless data[:data]
      fail MoySklad::BadApiResponseError unless data[:data]['collection']

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
