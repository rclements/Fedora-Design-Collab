require 'spec_helper'

describe User do 
  before(:each) do
    @valid_attributes = {
      :username => "bob"
    }
  end
  it "should print out the username when #to_s is called" do
    @user = User.create(@valid_attributes)
    @user.to_s.should == 'bob'
  end
end
