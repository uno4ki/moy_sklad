# coding: utf-8

require 'spec_helper'

describe 'CustomEntity' do

  describe :index do
    it "should return list of custom entitities" do
      ents = MoySklad::Models::CustomEntity.find(:all)
      expect(ents.metadata[:total]).to eq(ents.length)
    end
  end

  describe :find do
    it "should return entity with uuid e80d81e3-21ee-11e4-38df-002590a28eca" do
      entity = MoySklad::Models::CustomEntity.find("e80d81e3-21ee-11e4-38df-002590a28eca")
      expect(entity.entityMetadataUuid).to eq(CUSTOM_DICT[:payment_method])
      expect(entity.name).to eq("Безналичная оплата")
    end

    it "should return entity with uuid 8e2bec8e-21ee-11e4-0166-002590a28eca" do
      entity = MoySklad::Models::CustomEntity.find("8e2bec8e-21ee-11e4-0166-002590a28eca")
      expect(entity.entityMetadataUuid).to eq(CUSTOM_DICT[:delivery_method])
      expect(entity.name).to eq("Самовывоз")
    end
  end

  describe :create do

    it "should create and destroy new Entity" do
      entity = MoySklad::Models::CustomEntity.new
      entity.name = "повезу на собаках"
      entity.entityMetadataUuid = CUSTOM_DICT[:delivery_method]
      expect(entity.save).to eq(true)

      expect(entity.uuid.length).to eq(36)
      uuid = entity.uuid

      entity.destroy

      expect{MoySklad::Models::CustomEntity.find(uuid)}.to raise_error(ActiveResource::ResourceNotFound)
    end

    it "should create, update and destroy new Entity" do
      entity = MoySklad::Models::CustomEntity.new
      entity.name = "хочу бесплатно"
      entity.entityMetadataUuid = CUSTOM_DICT[:payment_method]
      expect(entity.save).to eq(true)

      expect(entity.uuid.length).to eq(36)
      uuid = entity.uuid

      entity = MoySklad::Models::CustomEntity.find(uuid)
      entity.name = "отработаю в поле"
      expect(entity.save).to eq(true)

      entity = MoySklad::Models::CustomEntity.find(uuid)
      expect(entity.name).to eq("отработаю в поле")
      expect(entity.entityMetadataUuid).to eq(CUSTOM_DICT[:payment_method])

      entity.destroy
      expect{MoySklad::Models::CustomEntity.find(uuid)}.to raise_error(ActiveResource::ResourceNotFound)
    end
  end
end
