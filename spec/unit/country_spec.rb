require 'spec_helper'

describe 'Country' do

  describe :index do
    it "should return list of countries" do
      cl = MoySklad::Model::Country.find(:all)
      expect(cl.metadata[:total]).to eq(cl.length)
    end

    it "should return correct uuid for code" do
      uuid = MoySklad::Model::Country.uuid_from_code(643)
      expect(uuid).to eq("9df7c2c3-7782-4c5c-a8ed-1102af611608")
    end

  end

end
