require 'spec_helper'

describe 'PaymentIn' do

  describe :index do
    it "should return list of payments" do
      payments = MoySklad::Model::PaymentIn.find(:all)
      expect(payments.metadata[:total]).to eq(payments.length)
    end
  end

  describe :find do
    it "should return payment" do
      payment = MoySklad::Model::PaymentIn.new
      payment.name = "test - payment"
      payment.sum.sum = 1000 * 100
      expect(payment.save).to eq(true)
      expect(payment.uuid.length).to eq(36)

      uuid = payment.uuid
      payment = MoySklad::Model::PaymentIn.find(uuid)
      expect(payment.name).to eq("test - payment")
      expect(payment.sum.sum).to eq("100000.0")
    end
  end

  describe :create do

    it "should create new empty PaymentIn" do
      payment = MoySklad::Model::PaymentIn.new
      expect(payment.save).to eq(true)
      expect(payment.uuid.length).to eq(36)
      payment.destroy
    end

    it "should create new non-empty PaymentIn" do
      payment = MoySklad::Model::PaymentIn.new
      payment.name = "test - payment"
      payment.sum.sum = 1000 * 100
      expect(payment.save).to eq(true)
      expect(payment.uuid.length).to eq(36)

      uuid = payment.uuid
      payment = MoySklad::Model::PaymentIn.find(uuid)
      expect(payment.name).to eq("test - payment")
      expect(payment.sum.sum).to eq("100000.0")
      expect(payment.sum.sumInCurrency).to eq("100000.0")
      payment.destroy

      expect{MoySklad::Model::PaymentIn.find(uuid)}.to raise_error(ActiveResource::ResourceNotFound)
    end

    it "should create new order + payment", pending: 'need real data in config' do
        order = MoySklad::Model::CustomerOrder.new
        order.name = "Test with payment - API"
        order.applicable = true
        order.targetAgentUuid = TGT_AGENT
        order.sourceStoreUuid = SRC_STORE
        order.sourceAgentUuid = SRC_AGENT
        order.stateUuid = CONFIRMED_UUID
        order.sum.sum = "100"
        order.sum.sumInCurrency = "100"

        KNOWN_ITEMS.each do |id, info|
          order.addItem(id, {quantity: info[:quantity],
              basePrice: { sum: info[:price] * 100, sumInCurrency: info[:price] * 100},
              price: { sum: info[:price] * 100, sumInCurrency: info[:price] * 100}})
        end

        ORDER_OPTIONS.each do |type, opt|
          order.setAttribute({uuid: opt[:key], value: :entityValueUuid}, opt[:value])
        end

        expect(order.save).to eq(true)
        expect(order.uuid.length).to eq(36)
        uuid = order.uuid

        payment = MoySklad::Model::PaymentIn.new
        payment.sum.sum = order.sum.sum
        payment.targetAgentUuid = TGT_AGENT
        payment.sourceAgentUuid = SRC_AGENT
        payment.describe = "Just a test"
        payment.customerOrderUuid = uuid

        expect(payment.save).to eq(true)
        expect(payment.uuid.length).to eq(36)

        # check order and bounded payment
        order = MoySklad::Model::CustomerOrder.find(uuid)
        expect(order.paymentsUuid.to_a(:financeInRef).first).to eq(payment.uuid)

        # Order can be destroyed only after the payment
        expect{order.destroy}.to raise_error(ActiveResource::ResourceNotFound)
        payment.destroy
        order.destroy
    end

    it "create payment and update applicable status", pending: 'need real data in config' do

      payment = MoySklad::Model::PaymentIn.new
      payment.targetAgentUuid = TGT_AGENT
      payment.sourceAgentUuid = SRC_AGENT
      payment.sum.sum = 1000 * 100
      expect(payment.save).to eq(true)
      uuid = payment.uuid

      payment = MoySklad::Model::PaymentIn.find(uuid)
      expect(payment.applicable).to eq("false")
      payment.applicable = "true"
      expect(payment.save).to eq(true)

      payment = MoySklad::Model::PaymentIn.find(uuid)
      expect(payment.applicable).to eq("true")

      payment.destroy

      expect{MoySklad::Model::PaymentIn.find(uuid)}.to raise_error(ActiveResource::ResourceNotFound)
    end
  end
end
