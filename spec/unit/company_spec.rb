require 'spec_helper'

describe 'Company' do

  describe :index do
    it "should return list of companies" do
      comps = MoySklad::Models::Company.find(:all)
      expect(comps.metadata[:total]).to eq(comps.length)
    end
  end

  describe :find do
    it "should return item with uuid 1f91e2b7-1ee7-11e4-b82f-002590a28eca" do
      company = MoySklad::Models::Company.find("1f91e2b7-1ee7-11e4-b82f-002590a28eca")
      expect(company.name).to eq("Светлана")
      expect(company.tags.tag).to eq("клиент")
    end

    it "should return item with uuid 1460b0a4-22d9-11e4-0aad-002590a28eca" do
      company = MoySklad::Models::Company.find("1460b0a4-22d9-11e4-0aad-002590a28eca")
      expect(company.name).to eq("Анастасия")
      expect(company.tags.tag).to match_array(["клиент", "дизайнер"])
    end
  end

  describe :create do

    it "should create and destroy new Company" do
      company = MoySklad::Models::Company.new
      company.name = "Test company"
      expect(company.save).to eq(true)

      expect(company.uuid.length).to eq(36)
      uuid = company.uuid

      company.destroy

      expect{MoySklad::Models::Company.find(uuid)}.to raise_error(ActiveResource::ResourceNotFound)
    end

    it "should create new Company with complex attributes" do
      company = MoySklad::Models::Company.new
      company.name = "Complex test company"
      company.contact.phones = "123456"
      company.contact.email = "foo@bar.baz"
      company.tags.tag = ["клиент", "дизайнер", "тест"]

      expect(company.save).to eq(true)

      uuid = company.uuid

      company = MoySklad::Models::Company.find(uuid)
      expect(company.contact.phones).to eq("123456")
      expect(company.contact.email).to eq("foo@bar.baz")
      expect(company.tags.tag).to match_array(["клиент", "дизайнер", "тест"])

      company.destroy
      expect{MoySklad::Models::Company.find(uuid)}.to raise_error(ActiveResource::ResourceNotFound)
    end
  end
end
