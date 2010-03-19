require File.dirname(__FILE__) + '/../spec_helper'

describe PagesController do
  describe "A logged-in user" do
    before(:each) do
      activate_authlogic
      inc_ary = create_project_with_owner
      @project = inc_ary[0]
      @user = inc_ary[1]
      create_user_session(@user)
    end

    describe "hitting #index" do
      before(:each) do
        get :index
      end

      it { response.should be_success }
    end
  end 
end 
