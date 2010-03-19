require File.dirname(__FILE__) + '/../spec_helper'
include Authlogic::TestCase

describe ApplicationController do

  describe "Authenticated examples" do
    before(:each) do
      activate_authlogic
      UserSession.create Factory.build(:valid_user)
    end
  end
end
