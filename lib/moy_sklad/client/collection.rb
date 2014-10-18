# Resources collection handler

require 'active_resource'
require 'active_support/core_ext/hash/conversions'
require 'active_support/core_ext/hash/indifferent_access'

module MoySklad::Client
  class Collection
    include Enumerable

    delegate :collect, :each, :length, :to => :to_a

    attr_reader :metadata

    attr_accessor :elements

    def initialize(data)

      @elements = data[:data]['collection'].delete(data[:object])
      @elements = [@elements] if @elements.is_a?(Hash)
      @metadata = HashWithIndifferentAccess.new(data[:data]['collection'])

      # Fix keys
      [:total, :start, :count].each do |k|
        @metadata[k] = @metadata[k].to_i if @metadata.has_key?(k)
      end
    end

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
end
