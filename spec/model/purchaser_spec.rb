require 'spec_helper'

describe Purchaser do
  context "validations" do
    subject {Fabricate.build(:purchaser)}
    it "should have a valid fabricator" do
      subject.should be_valid
    end

    it "verfy uniqueness of name" do
      subject.name = Fabricate(:purchaser).name
      subject.should_not be_valid  
    end

    it "verfy presence of name" do
      subject.name = nil
      subject.should_not be_valid
    end
  end
end
