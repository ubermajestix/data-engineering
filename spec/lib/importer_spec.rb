require 'spec_helper'

describe Importer do
  let(:merchant_attrs){ {name: "Milliways", address: "The end of time and matter"} }
  let(:existing_merchant){Fabricate(:merchant, merchant_attrs)}
  let(:person_attrs){{name: 'Arthur Dent'}}
  let(:existing_person){Fabricate(:person, person_attrs)}
  let(:item_attrs){ {description: "$10 off $20 of tea", price: 100} }
  let(:existing_item){Fabricate(:item, item_attrs.merge(merchant: existing_merchant))}
  let(:subsidiary_data){Fabricate(:subsidiary_data)}

  context "#perform" do
    it "should find SubsidiaryData and call process csv" do
      mock(Importer).process_csv(subsidiary_data.import_data.current_path)
      mock(SubsidiaryData).find(subsidiary_data.id){subsidiary_data}
      Importer.perform(subsidiary_data.id)
    end
  end

  context "creating objects from the tab file" do
    it "process the data provided by an upload object" do
      expect{
        Importer.perform(subsidiary_data.id)
      }.to change(Person, :count).by(3)
    end

    it "process the data provided by an upload object" do
      expect{
        Importer.perform(subsidiary_data.id)
      }.to change(Item, :count).by(3)
    end
    
    it "process the data provided by an upload object" do
      expect{
        Importer.perform(subsidiary_data.id)
      }.to change(Merchant, :count).by(3)
    end

    it "process the data provided by an upload object" do
      expect{
        Importer.perform(subsidiary_data.id)
      }.to change(Purchase, :count).by(12)
    end
  end

  context "handling errors" do
    it "should handle validation errors" do
      stub(Importer).create_merchant{
        #object_with_errors = Object.new
        #stub(object_with_errors).errors{}
        #stub(object_with_errors.errors).full_messages{ [] }dd
        raise ActiveRecord::RecordInvalid.new(existing_merchant)
      }
      expect{
        Importer.process_csv(subsidiary_data.import_data.current_path)
      }.to_not raise_error
    end
  end

  context "required for Resque" do
    it "should respond to perform" do
      Importer.should respond_to :perform
    end

    it "should be assigned a queue" do
      Importer.instance_variables.should include :@queue
    end
  end

  context "#create_merchant" do

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

    it "should create an item given a hash and a merchant" do
      expect{
        Importer.create_item(existing_merchant, item_attrs)
      }.to change(Item, :count).by(1)
    end

    it "should assign the merchant to the item" do
      Importer.create_item(existing_merchant, item_attrs).merchant.should == existing_merchant
    end

    it "should find an existing item" do
      existing_item
      Importer.create_item(existing_merchant, item_attrs).should == existing_item
    end

    it "can raise validation errors" do
      expect{
        Importer.create_item(existing_merchant, price: 10)
      }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  context "#create_person" do

    it "should create a person given a hash" do
      expect{
        Importer.create_person(person_attrs)
      }.to change(Person, :count).by(1)
    end

    it "should find an existing person" do
      existing_person
      Importer.create_person(person_attrs).should == existing_person
    end

    it "can raise validation errors" do
      expect{
        Importer.create_person(name: '')
      }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  context "#create_purchases" do
    it "should create a given number of purchases" do
      expect{
        Importer.create_purchases(existing_person, existing_item, 2)
      }.to change(Purchase, :count).by(2)
    end

    it "can raise validation error if person is nil" do
      expect{
        Importer.create_purchases(nil, existing_item, 2)
      }.to raise_error ActiveRecord::RecordInvalid
    end

    it "can raise validation error if item is nil" do
      expect{
        Importer.create_purchases(existing_person, nil, 2)
      }.to raise_error ActiveRecord::RecordInvalid
    end

    it "will not create purchases if count is nil" do
      expect{
        Importer.create_purchases(existing_person, existing_item, nil)
      }.to change(Purchase, :count).by(0)
    end

    # This test demonstrates the downside of using to_i to convert the
    # count. It is here to aid in converting to another approach and
    # alerts the developer to a potential issue.
    it "will not create purchases if count can't be converted to an integer" do
      expect{
        Importer.create_purchases(existing_person, existing_item, "3ffa6")
      }.to change(Purchase, :count).by(3)
    end
  end
end
