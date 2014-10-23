require 'spec_helper'

describe 'Supply' do

  describe :index do
    it "should return list of supplies" do
      sups = MoySklad::Model::Supply.find(:all)
      expect(sups.metadata[:total]).to eq(sups.length)
    end
  end

  describe :find do
    it "should return supply" do
      supply = MoySklad::Model::Supply.find("82b6d97d-5ac6-11e4-90a2-8ecb00122a26")
      expect(supply.uuid).to eq("82b6d97d-5ac6-11e4-90a2-8ecb00122a26")
      expect(supply.to_a(:shipmentIn).length).to eq(1)
    end
  end

  describe :create do

    it "should create new empty Supply" do
      supply = MoySklad::Model::Supply.new
      supply.targetStoreUuid = "b6fd1ae5-213c-11e4-a18f-002590a28eca"
      expect(supply.save).to eq(true)
      expect(supply.uuid.length).to eq(36)
      supply.destroy
    end

    it "should create new non-empty Supply" do
      supply = MoySklad::Model::Supply.new
      supply.targetStoreUuid = "b6fd1ae5-213c-11e4-a18f-002590a28eca"
      supply.sourceAgentUuid = "a114c0a4-5ab2-11e4-7a07-673d00178e52"
      supply.targetAgentUuid = "13187298-1ee5-11e4-7dd5-002590a28eca"
      supply.applicable = true
      supply.add_item("9eccf56d-5ab4-11e4-90a2-8ecb000e5298", { quantity: 850 })
      expect(supply.save).to eq(true)
      expect(supply.uuid.length).to eq(36)

      uuid = supply.uuid
      supply = MoySklad::Model::Supply.find(uuid)
      expect(supply.sum.sum).to eq("0.0")
      expect(supply.sum.sumInCurrency).to eq("0.0")
      expect(supply.to_a(:shipmentIn).length).to eq(1)
      supply.destroy

      expect{MoySklad::Model::Supply.find(uuid)}.to raise_error(ActiveResource::ResourceNotFound)
    end

  end
end
