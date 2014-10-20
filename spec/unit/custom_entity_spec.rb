require 'spec_helper'

describe 'CustomEntity' do

  describe :index do
    it "should return list of custom entitities" do
      ents = MoySklad::Model::CustomEntity.find(:all)
      expect(ents.metadata[:total]).to eq(ents.length)
    end
  end

  describe :find do
    it "should return entity", pending: 'need real data in config' do
      entity = MoySklad::Model::CustomEntity.new
      entity.name = "повезу на собаках"
      entity.entityMetadataUuid = CUSTOM_DICT[:delivery_method]
      expect(entity.save).to eq(true)

      expect(entity.uuid.length).to eq(36)
      uuid = entity.uuid
      entity = MoySklad::Model::CustomEntity.find(uuid)
      expect(entity.entityMetadataUuid).to eq(CUSTOM_DICT[:payment_method])
      expect(entity.name).to eq("Безналичная оплата")
    end
  end

  describe :create do

    it "should create and destroy new Entity", pending: 'need real data in config' do
      entity = MoySklad::Model::CustomEntity.new
      entity.name = "повезу на собаках"
      entity.entityMetadataUuid = CUSTOM_DICT[:delivery_method]
      expect(entity.save).to eq(true)

      expect(entity.uuid.length).to eq(36)
      uuid = entity.uuid

      entity.destroy

      expect{MoySklad::Model::CustomEntity.find(uuid)}.to raise_error(ActiveResource::ResourceNotFound)
    end

    it "should create, update and destroy new Entity", pending: 'need real data in config' do
      entity = MoySklad::Model::CustomEntity.new
      entity.name = "хочу бесплатно"
      entity.entityMetadataUuid = CUSTOM_DICT[:payment_method]
      expect(entity.save).to eq(true)

      expect(entity.uuid.length).to eq(36)
      uuid = entity.uuid

      entity = MoySklad::Model::CustomEntity.find(uuid)
      entity.name = "отработаю в поле"
      expect(entity.save).to eq(true)

      entity = MoySklad::Model::CustomEntity.find(uuid)
      expect(entity.name).to eq("отработаю в поле")
      expect(entity.entityMetadataUuid).to eq(CUSTOM_DICT[:payment_method])

      entity.destroy
      expect{MoySklad::Model::CustomEntity.find(uuid)}.to raise_error(ActiveResource::ResourceNotFound)
    end
  end
end
