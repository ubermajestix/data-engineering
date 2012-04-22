require 'spec_helper'

describe Item do
  context "price" do
    it "should default to 0 if no price is given" do
      i = Item.new
      i.price.should == 0
    end
    it "should store price in cents" do
      i = Item.new(price: 10)
      i.price_in_cents.should == 1000
    end

    it "should find items by price (in cents)" do
      item = Fabricate(:item)
      Item.where(price_in_cents: item.price.cents).first.should == item
    end
  end

  context "validations" do
    subject {Fabricate.build(:item)}
    
    let(:existing_item){Fabricate(:item)}

    it 'should have a valid fabricator' do
      subject.should be_valid
    end

    it "verify description's presence" do
      subject.description = nil
      subject.should_not be_valid
    end

    it "verify description is unique" do
      subject.description = existing_item.description
      subject.should_not be_valid
    end

    it "verify a merchant_id present" do
      subject.merchant_id = nil
      subject.should_not be_valid
    end
  end
end
