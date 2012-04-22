require 'spec_helper'

describe Person do
  context "validations" do
    subject {Fabricate.build(:person)}
    it "should have a valid fabricator" do
      subject.should be_valid
    end

    it "verfy uniqueness of name" do
      subject.name = Fabricate(:person).name
      subject.should_not be_valid  
    end

    it "verfy presence of name" do
      subject.name = nil
      subject.should_not be_valid
    end
  end
end
