require 'spec_helper'

describe 'Company' do

  describe :index do
    it "should return list of companies" do
      comps = MoySklad::Model::Company.find(:all)
      expect(comps.metadata[:total]).to eq(comps.length)
    end
  end

  describe :find do
    it "should find company" do
      company = MoySklad::Model::Company.new
      company.name = "Test company"
      expect(company.save).to eq(true)

      uuid = company.uuid

      company = MoySklad::Model::Company.find(uuid)
      expect(company.name).to eq("Test company")
    end
  end

  describe :create do

    it "should create and destroy new Company" do
      company = MoySklad::Model::Company.new
      company.name = "Test company"
      expect(company.save).to eq(true)

      expect(company.uuid.length).to eq(36)
      uuid = company.uuid

      company.destroy

      expect{MoySklad::Model::Company.find(uuid)}.to raise_error(ActiveResource::ResourceNotFound)
    end

    it "should create new Company with complex attributes" do
      company = MoySklad::Model::Company.new
      company.name = "Complex test company"
      company.contact.phones = "123456"
      company.contact.email = "foo@bar.baz"
      company.tags.tag = ["клиент", "дизайнер", "тест"]

      expect(company.save).to eq(true)

      uuid = company.uuid

      company = MoySklad::Model::Company.find(uuid)
      expect(company.contact.phones).to eq("123456")
      expect(company.contact.email).to eq("foo@bar.baz")
      expect(company.tags.tag).to match_array(["клиент", "дизайнер", "тест"])

      company.destroy
      expect{MoySklad::Model::Company.find(uuid)}.to raise_error(ActiveResource::ResourceNotFound)
    end
  end
end
