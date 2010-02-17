require 'spec_helper'

describe Inspiration do
  before(:each) do
    @valid_attributes = {
      :title => "test inspiration"
    }
  end

  it "should create a new instance given valid attributes" do
    Inspiration.create!(@valid_attributes)
  end

  it { should validate_presence_of :title }

  it "should print out the title when #to_s is called" do
    @inspiration = Inspiration.create(@valid_attributes)
    @inspiration.to_s.should == 'test inspiration'
  end
end
