# coding: utf-8

require 'spec_helper'
require 'securerandom'

describe 'Good' do

  describe :index do
    it "should return list of items" do
      items = MoySklad::Models::Good.find(:all)
      expect(items.metadata[:total]).to eq(items.length)
      len = items.metadata[:total]

      # Newly update items, should be less then total
      items = MoySklad::Models::Good.find(:all, params: { filter:  "updated>20141014010000"})
      expect(items.metadata[:total]).to be < len
    end
  end

  describe :find do
    it "should return item with uuid 05eca138-3da6-11e4-0135-002590a28eca" do
      item = MoySklad::Models::Good.find("05eca138-3da6-11e4-0135-002590a28eca")
      expect(item.name).to eq("СТОЛИК КОКТЕЙЛЬНЫЙ ST.JAMES")
      expect(item.barcode.barcode).to eq("2000000004846")
      expect(item.uomUuid).to eq("19f1edc0-fc42-4001-94cb-c9ec9c62ec10")
    end
  end

  describe "Simple attribute update" do
    before(:all) do
      item = MoySklad::Models::Good.new
      item.name = "Simple test item for attr update test"
      item.save
      @uuid = item.uuid
      @randomPrice = rand(1.0..100.0).round(2)
    end

    after(:all) do
      MoySklad::Models::Good.find(@uuid).destroy
    end

    it "and update attr" do
      item = MoySklad::Models::Good.find(@uuid)
      expect(item.buyPrice).to eq("0.0")
      item.buyPrice = @randomPrice
      expect(item.save).to eq(true)
    end

    it "and read attr" do
      item = MoySklad::Models::Good.find(@uuid)
      expect(item.buyPrice.to_f).to eq(@randomPrice)
    end
  end

  describe "create and update" do

    it "should create a new Good" do
      item = MoySklad::Models::Good.new
      item.name = "Just a test item, с русскими букавами in da name"
      item.description = "Отличный итем, шерстянной такой"
      expect(item.save).to eq(true)

      expect(item.uuid.length).to eq(36) # Should looks like real uuid

      uuid = item.uuid

      # Check item on server
      item = MoySklad::Models::Good.find(uuid)
      expect(item.uuid).to eq(uuid)

      # Remove item
      item.destroy

      expect{MoySklad::Models::Good.find(uuid)}.to raise_error(ActiveResource::ResourceNotFound)
    end

    describe "should create item with salePrice and able to update only default" do

      PRICE_CUR = "131c74fb-1ee5-11e4-a138-002590a28eca"

      before(:all) do
        item = MoySklad::Models::Good.new
        item.name = "Test item with custom prices"

        item.set_sale_price(PRICE_CUR, 100)

        item.save
        @uuid = item.uuid
      end

      after(:all) do
        MoySklad::Models::Good.find(@uuid).destroy
      end

      it "and get price" do
        item = MoySklad::Models::Good.find(@uuid)
        expect(item.get_sale_price(PRICE_CUR).value.to_f / 100).to eq(100)
      end

      it "and update CUR price (only default price can be updated)" do
        item = MoySklad::Models::Good.find(@uuid)

        item.set_sale_price(PRICE_CUR, 1000)
        expect(item.save).to eq(true)

        expect(item.get_sale_price(PRICE_CUR).value.to_f / 100).to eq(1000)
      end
    end


    describe "item with custom attributes" do

      META_COUNTRY  = {uuid: "9bdf2792-2c52-11e4-ea35-002590a28eca", value: :valueString}
      META_ARTNO    = {uuid: "eb396242-1efe-11e4-d971-002590a28eca", value: :valueString}
      META_LINK     = {uuid: "51e20842-22eb-11e4-a5c3-002590a28eca", value: :valueText}

      let(:partno)  { SecureRandom.hex }
      let(:country) { SecureRandom.hex }
      let(:link)    { SecureRandom.hex }

      before(:all) do
        item = MoySklad::Models::Good.new
        item.name = "Test item with custom attributes"
        item.save
        @uuid = item.uuid
      end

      after(:all) do
        MoySklad::Models::Good.find(@uuid).destroy
      end

      it "should test empty attrs" do
        item = MoySklad::Models::Good.find(@uuid)

        expect(item.getAttribute(META_LINK[:uuid])).to be_nil
        expect(item.getAttribute(META_ARTNO[:uuid])).to be_nil
        expect(item.getAttribute(META_COUNTRY[:uuid])).to be_nil
      end

      it "set and read attrs" do
        item = MoySklad::Models::Good.find(@uuid)

        item.setAttribute(META_COUNTRY, country)
        item.setAttribute(META_LINK, link)
        item.setAttribute(META_ARTNO, partno)

        expect(item.save).to eq(true)

        item = MoySklad::Models::Good.find(@uuid)
        expect(item.getAttribute(META_LINK[:uuid]).valueText).to eq(link)
        expect(item.getAttribute(META_ARTNO[:uuid]).valueString).to eq(partno)
        expect(item.getAttribute(META_COUNTRY[:uuid]).valueString).to eq(country)
      end

    end
  end

end
