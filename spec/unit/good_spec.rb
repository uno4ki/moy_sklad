require 'spec_helper'
require 'securerandom'

describe 'Good' do

  describe :index do
    it "should return list of items" do
      items = MoySklad::Model::Good.find(:all)
      expect(items.metadata[:total]).to eq(items.length)
      len = items.metadata[:total]

      # Newly update items, should be less then total
      items = MoySklad::Model::Good.find(:all, params: { filter:  "updated>20141014010000"})
      expect(items.metadata[:total]).to be < len
    end
  end

  describe :find do
    it "should return good" do
      item = MoySklad::Model::Good.new
      item.name = "Sample good"
      item.save
      item = MoySklad::Model::Good.find(item.uuid)
      expect(item.name).to eq("Sample good")
    end
  end

  describe "Simple attribute update" do
    before(:all) do
      item = MoySklad::Model::Good.new
      item.name = "Simple test item for attr update test"
      item.save
      @uuid = item.uuid
      @randomPrice = rand(1.0..100.0).round(2)
    end

    after(:all) do
      MoySklad::Model::Good.find(@uuid).destroy
    end

    it "and update attr" do
      item = MoySklad::Model::Good.find(@uuid)
      expect(item.buyPrice).to eq("0.0")
      item.buyPrice = @randomPrice
      expect(item.save).to eq(true)
    end

    it "and read attr" do
      item = MoySklad::Model::Good.find(@uuid)
      expect(item.buyPrice.to_f).to eq(@randomPrice)
    end
  end

  describe "create and update" do
    it "should create a new Good" do
      item = MoySklad::Model::Good.new
      item.name = "Just a test item, с русскими букавами in da name"
      item.description = "Отличный итем, шерстянной такой"
      expect(item.save).to eq(true)

      expect(item.uuid.length).to eq(36) # Should looks like real uuid

      uuid = item.uuid

      # Check item on server
      item = MoySklad::Model::Good.find(uuid)
      expect(item.uuid).to eq(uuid)

      # Remove item
      item.destroy

      expect{MoySklad::Model::Good.find(uuid)}.to raise_error(ActiveResource::ResourceNotFound)
    end

    describe "should create item with salePrice and able to update only default",
             pending: 'need real data in config' do
      before(:all) do
        item = MoySklad::Model::Good.new
        item.name = "Test item with custom prices"

        item.set_sale_price(PRICE_CUR, 100)

        item.save
        @uuid = item.uuid
      end

      after(:all) do
        MoySklad::Model::Good.find(@uuid).destroy
      end

      it "and get price" do
        item = MoySklad::Model::Good.find(@uuid)
        expect(item.get_sale_price(PRICE_CUR).value.to_f / 100).to eq(100)
      end

      it "and update CUR price (only default price can be updated)" do
        item = MoySklad::Model::Good.find(@uuid)

        item.set_sale_price(PRICE_CUR, 1000)
        expect(item.save).to eq(true)

        expect(item.get_sale_price(PRICE_CUR).value.to_f / 100).to eq(1000)
      end
    end

    describe "item with custom attributes" do
      let(:partno)  { SecureRandom.hex }
      let(:country) { SecureRandom.hex }
      let(:link)    { SecureRandom.hex }

      before(:all) do
        item = MoySklad::Model::Good.new
        item.name = "Test item with custom attributes"
        item.save
        @uuid = item.uuid
      end

      after(:all) do
        MoySklad::Model::Good.find(@uuid).destroy
      end

      it "should test empty attrs", pending: 'need real data in config' do
        item = MoySklad::Model::Good.find(@uuid)

        expect(item.get_attribute(META_LINK[:uuid])).to be_nil
        expect(item.get_attribute(META_ARTNO)).to be_nil
        expect(item.get_attribute(META_COUNTRY)).to be_nil
        expect{item.get_attribute("foo")}.to raise_error(ArgumentError)
      end

      it "set and read attrs", pending: 'need real data in config' do
        item = MoySklad::Model::Good.find(@uuid)

        item.set_attribute(META_COUNTRY, country)
        item.set_attribute(META_LINK, link)
        item.set_attribute(META_ARTNO, partno)

        expect(item.save).to eq(true)

        item = MoySklad::Model::Good.find(@uuid)
        expect(item.get_attribute(META_LINK)).to eq(link)
        expect(item.get_attribute(META_ARTNO)).to eq(partno)
        expect(item.get_attribute(META_COUNTRY[:uuid]).valueString).to eq(country)
      end

    end
  end

end
