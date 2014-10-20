require 'spec_helper'

describe 'GoodFolder' do

  describe :index do
    it "should return list of folders" do
      folders = MoySklad::Model::GoodFolder.find(:all)
      expect(folders.metadata[:total]).to eq(folders.length)
    end
  end

  describe :find do
    it "should return item" do
      folder = MoySklad::Model::GoodFolder.new
      folder.name = "Test::top level"
      expect(folder.save).to eq(true)
      folder = MoySklad::Model::GoodFolder.find(folder.uuid)
      expect(folder.name).to eq("Test::top level")
    end
  end

  describe :create do

    it "should create new GoodFolder" do
      folder = MoySklad::Model::GoodFolder.new
      folder.name = "Test folder"
      expect(folder.save).to eq(true)
      expect(folder.uuid.length).to eq(36)
      folder.destroy
    end

    it "create tree" do
      folder = MoySklad::Model::GoodFolder.new
      folder.name = "Test::top level"
      expect(folder.save).to eq(true)

      subfolder = MoySklad::Model::GoodFolder.new({name: "Sublevel folder", parentUuid: folder.uuid})
      expect(subfolder.save).to eq(true)

      expect(subfolder.parentUuid).to eq(folder.uuid)

      uuid = folder.uuid
      suuid = subfolder.uuid

      folder.destroy

      expect{MoySklad::Model::GoodFolder.find(uuid)}.to raise_error(ActiveResource::ResourceNotFound)
      expect{MoySklad::Model::GoodFolder.find(suuid)}.to raise_error(ActiveResource::ResourceNotFound)
    end
  end
end
