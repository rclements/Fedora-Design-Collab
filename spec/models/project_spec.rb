require 'spec_helper'

describe Project do
  before(:each) do
    @valid_attributes = {
      :title => "test project"
    }
  end

  it "should create a new instance given valid attributes" do
    Project.create!(@valid_attributes)
  end

  it { should validate_presence_of :title }

  it "should print out the title when #to_s is called" do
    @project = Project.create(@valid_attributes)
    @project.to_s.should == 'test project'
  end
end
