require 'spec_helper'

describe Merchant do
  # To me, testing validations is important b/c I want tests
  # to fail if the validations are removed in the future. I know
  # this falls under the "don't test the framework" but I've saved
  # myself lots of headaches by including these tests in the past.
  context "validations" do
    subject{Fabricate.build(:merchant)}
    
    let(:existing_merchant){Fabricate(:merchant)}

    it "should verfiy presence of name" do
      subject.name = nil
      subject.should_not be_valid
    end

    it "should verify uniqueness of name" do
      subject.name = existing_merchant.name
      subject.should_not be_valid
    end

    it "should verify presence of an address" do
      subject.address = nil
      subject.should_not be_valid
    end

    it "should verify uniqueness of an address" do
      subject.address = existing_merchant.address
      subject.should_not be_valid
    end
  end
end
