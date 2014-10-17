# coding: utf-8

require 'spec_helper'

describe "Some fail tests" do

  it "should return error on save (invalid uuid)" do
    p = Moysklad::Models::PaymentIn.new
    p.demandsUuid = [nil]

    expect(p.save).to eq(false)
    expect(p.error.message).to eq("Invalid UUID string: ")
  end
end
