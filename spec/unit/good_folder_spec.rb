require 'spec_helper'

describe 'GoodFolder' do

  describe :index do
    it "should return list of folders" do
      folders = MoySklad::Models::GoodFolder.find(:all)
      expect(folders.metadata[:total]).to eq(folders.length)
    end
  end

  describe :find do
    it "should return item with uuid a3e322e1-1ef1-11e4-9fd4-002590a28eca" do
      folder = MoySklad::Models::GoodFolder.find("a3e322e1-1ef1-11e4-9fd4-002590a28eca")
      expect(folder.name).to eq("Винные, коктейльные, барные столики")
    end
  end

  describe :create do

    it "should create new GoodFolder" do
      folder = MoySklad::Models::GoodFolder.new
      folder.name = "Test folder"
      expect(folder.save).to eq(true)
      expect(folder.uuid.length).to eq(36)
      folder.destroy
    end

    it "create tree" do
      folder = MoySklad::Models::GoodFolder.new
      folder.name = "Test::top level"
      expect(folder.save).to eq(true)

      subfolder = MoySklad::Models::GoodFolder.new({name: "Sublevel folder", parentUuid: folder.uuid})
      expect(subfolder.save).to eq(true)

      expect(subfolder.parentUuid).to eq(folder.uuid)

      uuid = folder.uuid
      suuid = subfolder.uuid

      folder.destroy

      expect{MoySklad::Models::GoodFolder.find(uuid)}.to raise_error(ActiveResource::ResourceNotFound)
      expect{MoySklad::Models::GoodFolder.find(suuid)}.to raise_error(ActiveResource::ResourceNotFound)
    end
  end
end
