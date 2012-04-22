require 'spec_helper'

describe Importer do
  context "required for Resque" do
    it "should respond to perform" do
      Importer.should respond_to :perform
    end

    it "should be assigned a queue" do
      Importer.instance_variables.should include :@queue
    end
  end

  context "#create_merchant" do
    let(:merchant_attrs){ {name: "Milliways", address: "The end of time and matter"} }
    let(:existing_merchant){Fabricate(:merchant, merchant_attrs)}

    it "should create a merchant if one doesn't exist" do
      expect{
        Importer.create_merchant(merchant_attrs)
      }.to change(Merchant, :count).by(1)
    end

    it "should not create a merchant if already exists" do
      # calls the method defined by let and creates the Merchant
      existing_merchant 
      expect{
        Importer.create_merchant(merchant_attrs)
      }.to change(Merchant, :count).by(0)
    end

    it "should return an exiting merchant" do
      existing_merchant 
      Importer.create_merchant(merchant_attrs).should == existing_merchant
    end

    it "should not create a merchant with blank strings" do
      expect{
        Importer.create_merchant(name: '', address: '')
      }.to raise_error ActiveRecord::RecordInvalid
    end

    it "will raise validation errors" do
      expect{
        Importer.create_merchant(name: 'blowzup')
      }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  context "#create_item" do
    let(:merchant){Fabricate(:merchant)}
    let(:item_attrs){ {description: "$10 off $20 of tea", price: 100} }
    it "should create an item given a hash and a merchant" do
      expect{
        Importer.create_item(merchant, item_attrs)
      }.to change(Item, :count).by(1)
    end
  end
end
