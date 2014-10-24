require 'spec_helper'

describe 'Demand' do

  describe :index do
    it "should return list of demands" do
      sups = MoySklad::Model::Demand.find(:all)
      expect(sups.metadata[:total]).to eq(sups.length)
    end
  end

  describe :find do
    it "should return demand" do
      demand = MoySklad::Model::Demand.find("91fbb933-5b4f-11e4-90a2-8ecb0019b941")
      expect(demand.uuid).to eq("91fbb933-5b4f-11e4-90a2-8ecb0019b941")
      expect(demand.to_a(:shipmentOut).length).to eq(1)
    end
  end

  describe :create do

    it "should create new empty Demand" do
      demand = MoySklad::Model::Demand.new
      demand.sourceStoreUuid = "b6fd1ae5-213c-11e4-a18f-002590a28eca"
      demand.customerOrderUuid = "f4fc79f6-5b4b-11e4-7a07-673d00379d95"
      expect(demand.save).to eq(true)
      expect(demand.uuid.length).to eq(36)
      demand.destroy
    end

    it "should create new non-empty Demand" do
      demand = MoySklad::Model::Demand.new
      demand.sourceStoreUuid = "b6fd1ae5-213c-11e4-a18f-002590a28eca"
      demand.targetAgentUuid = "a114c0a4-5ab2-11e4-7a07-673d00178e52"
      demand.sourceAgentUuid = "13187298-1ee5-11e4-7dd5-002590a28eca"
      demand.customerOrderUuid = "f4fc79f6-5b4b-11e4-7a07-673d00379d95"
      demand.applicable = true
      demand.add_item("9eccf56d-5ab4-11e4-90a2-8ecb000e5298", { quantity: 850 })
      expect(demand.save).to eq(true)
      expect(demand.uuid.length).to eq(36)

      uuid = demand.uuid
      demand = MoySklad::Model::Demand.find(uuid)
      expect(demand.sum.sum).to eq("0.0")
      expect(demand.sum.sumInCurrency).to eq("0.0")
      expect(demand.to_a(:shipmentOut).length).to eq(1)
      demand.destroy

      expect{MoySklad::Model::Demand.find(uuid)}.to raise_error(ActiveResource::ResourceNotFound)
    end

  end
end
