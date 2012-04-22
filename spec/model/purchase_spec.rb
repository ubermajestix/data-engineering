require 'spec_helper'

describe Purchase do
  context "validations" do
    subject{ Fabricate.build(:purchase) } 
    it "has a valid fabricator" do
      subject.should be_valid
    end
    
    it "verify presence of a purchaser" do
      subject.purchaser = nil
      subject.should_not be_valid
    end

    it "verfiy presences of an item" do
      subject.item = nil
      subject.should_not be_valid
    end
  end
end
