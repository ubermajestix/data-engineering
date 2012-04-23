require "spec_helper"

describe Accounting do

  let(:purchases){
    [Fabricate(:purchase, item: Fabricate(:item, price: 5)), 
     Fabricate(:purchase, item: Fabricate(:item, price: 10))]
  }

  subject{Accounting.new(purchases)}

  it "should return the gross revenue given an Array of Purchase objects" do
    puts subject.revenue.inspect
    subject.revenue.should == Money.new(1500)
  end
end
