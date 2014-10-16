# coding: utf-8

require 'spec_helper'

TGT_AGENT = "13187298-1ee5-11e4-7dd5-002590a28eca"
SRC_STORE = "131a5a52-1ee5-11e4-44b9-002590a28eca"
SRC_AGENT = "a493904f-1ee9-11e4-7acf-002590a28eca"

# Some known items from MS
KNOWN_ITEMS = {
  "5fa2a3be-21ea-11e4-8d22-002590a28eca" => {quantity: 2, name: "Библиотека открытая", price: 142560},
  "c4fc2b7f-21ea-11e4-dd97-002590a28eca" => {quantity: 1, name: "Люстра SMALL BIRDCAGE CRYSTAL CHANDELIER", price: 15400.80},
  "095f83da-22d7-11e4-491d-002590a28eca" => {quantity: 7, name: "Пуф \"Mestre\"", price: 24840}
}

ORDER_OPTIONS = {
  delivery: {
    key: "6caae3cd-21ee-11e4-77f4-002590a28eca",
    value: "7d22ccf4-21ee-11e4-1416-002590a28eca"
  },
  communicate: {
    key: "754e56ad-2206-11e4-f8df-002590a28eca",
    value: "531f27f3-2206-11e4-9083-002590a28eca"
  },
  payments: {
    key: "bf1f15bc-21ee-11e4-a089-002590a28eca",
    value: "e80d81e3-21ee-11e4-38df-002590a28eca"
  },
  source: {
    key: "2f42de34-22df-11e4-de13-002590a28eca",
    value: "9d1c8c06-22e0-11e4-439c-002590a28eca"
  }
}

CONFIRMED_UUID = "a7f2f9ea-2c5f-11e4-314c-002590a28eca"

describe 'CustomerOrder' do

  describe :index do

    it "should enumerate orders, customers and goods (consistency test)" do
      orders = Moysklad::Models::CustomerOrder.find(:all)
      expect(orders.metadata[:total]).to eq(orders.length)

      sample = 5
      sample = orders.metadata[:total] if orders.metadata[:total] < 5

      # Don't check ALL orders, only 5 or less
      orders.to_a.sample(sample).each do |o|
        cost = 0
        expect(o.sourceAgentUuid.length).to eq(36) # uuid

        customer = Moysklad::Models::Company.find(o.sourceAgentUuid)
        # puts "#{o.uuid} [##{o.name}] by #{customer.name}"
        o.getArray(:customerOrderPosition).each do |p|

          cost += ((p.quantity.to_f * p.price.sum.to_f) / 100) ## XXX zero price found in invalid orders

          expect(p.goodUuid.length).to eq(36) # uuid
          good = Moysklad::Models::Good.find(p.goodUuid)
          # puts " - #{good.uuid} [#{good.name}], #{p.quantity}"
        end
        # puts " total cost: #{cost}"
      end
    end
  end

  describe :find do
    it "should return order with uuid eef4b3d4-1eea-11e4-8874-002590a28eca" do
      order = Moysklad::Models::CustomerOrder.find("eef4b3d4-1eea-11e4-8874-002590a28eca")
      customer = Moysklad::Models::Company.find(order.sourceAgentUuid)
      expect(order.name).to eq("11295")
      expect(customer.name).to eq("Елена Лосенко")
      expect(order.getArray(:customerOrderPosition).length).to eq(11) # 11 items in order
    end
  end

  describe :create do
      it "should create new empty Order" do
        order = Moysklad::Models::CustomerOrder.new
        expect(order.save).to eq(true)
        expect(order.uuid.length).to eq(36)
        uuid = order.uuid
        order.destroy
        expect{Moysklad::Models::CustomerOrder.find(uuid)}.to raise_error(ActiveResource::ResourceNotFound)
      end

      it "should create new Order with values" do
        order = Moysklad::Models::CustomerOrder.new
        order.name = "12345 - api test"
        order.targetAgentUuid = TGT_AGENT
        order.sourceStoreUuid = SRC_STORE
        order.sourceAgentUuid = SRC_AGENT
        expect(order.save).to eq(true)
        expect(order.uuid.length).to eq(36)
        uuid = order.uuid

        order = Moysklad::Models::CustomerOrder.find(uuid)
        expect(order.name).to eq("12345 - api test")
        expect(order.targetAgentUuid).to eq(TGT_AGENT)
        expect(order.sourceStoreUuid).to eq(SRC_STORE)
        expect(order.sourceAgentUuid).to eq(SRC_AGENT)

        customer = Moysklad::Models::Company.find(order.sourceAgentUuid)
        expect(customer.name).to eq("Елена Лосенко")
        order.destroy
        expect{Moysklad::Models::CustomerOrder.find(uuid)}.to raise_error(ActiveResource::ResourceNotFound)
      end

      it "should create order with items and check cost" do
        order = Moysklad::Models::CustomerOrder.new
        order.name = "12345 - api test [items]"
        order.applicable = true
        order.targetAgentUuid = TGT_AGENT
        order.sourceStoreUuid = SRC_STORE
        order.sourceAgentUuid = SRC_AGENT
        order.stateUuid = CONFIRMED_UUID
        order.sum.sum = "100"
        order.sum.sumInCurrency = "100"

        KNOWN_ITEMS.each do |id, info|
          order.addItem(id, {quantity: info[:quantity], basePrice: { sum: info[:price] * 100, sumInCurrency: info[:price] * 100}})
        end

        ORDER_OPTIONS.each do |type, opt|
          order.setAttribute({uuid: opt[:key], value: :entityValueUuid}, opt[:value])
        end

        expect(order.save).to eq(true)
        expect(order.uuid.length).to eq(36)
        uuid = order.uuid

        order = Moysklad::Models::CustomerOrder.find(uuid)
        expect(order.name).to eq("12345 - api test [items]")
        expect(order.targetAgentUuid).to eq(TGT_AGENT)
        expect(order.sourceStoreUuid).to eq(SRC_STORE)
        expect(order.sourceAgentUuid).to eq(SRC_AGENT)
        expect(order.stateUuid).to eq(CONFIRMED_UUID)

        ORDER_OPTIONS.each do |type, opt|
          expect(order.getAttribute(opt[:key]).entityValueUuid).to eq(opt[:value])
        end

        # This is NORMAL, order sum is always zero :D
        expect(order.sum.sum).to eq("0.0")
        expect(order.sum.sumInCurrency).to eq("0.0")

        expect(order.customerOrderPosition.length).to eq(KNOWN_ITEMS.keys.length)
        customer = Moysklad::Models::Company.find(order.sourceAgentUuid)
        expect(customer.name).to eq("Елена Лосенко")

        order.destroy
        expect{Moysklad::Models::CustomerOrder.find(uuid)}.to raise_error(ActiveResource::ResourceNotFound)

      end
   end
end
