require File.dirname(__FILE__) + '/../spec_helper'
include Authlogic::TestCase

describe UserSessionsController do

    describe "GET new" do
      it "redirects to the root page" do
        get :new
      end
    end
    
    describe "responding to POST create" do
      it "should log in the correct user" do
        post :create, :user_session => {:username => "quencom", :password => 'foobar'}
      end
      
      it "should redirect to root" do
        response.should redirect_to(root_url)
    end

    describe "post to #destroy user_session" do
      it "should destroy a current_user_session" do
        post :destroy, { :current_user_session => { :user_session_id => '1'} }
      end

      it "should redirect to root" do
        response.should redirect_to(root_url)
      end
    end
  end
end

