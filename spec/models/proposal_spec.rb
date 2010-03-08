require 'spec_helper'

describe Proposal do
  before(:each) do
    @valid_attributes = {
      :title => "test proposal", :content => "blah"
    }
  end

  it "should create a new instance given valid attributes" do
    Proposal.create!(@valid_attributes)
  end

  it { should validate_presence_of :title }

  it "should print out the title when #to_s is called" do
    @proposal = Proposal.create(@valid_attributes)
    @proposal.to_s.should == 'test proposal'
  end
end
