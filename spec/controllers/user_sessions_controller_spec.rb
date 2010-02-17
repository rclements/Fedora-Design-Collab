require File.dirname(__FILE__) + '/../spec_helper'
include Authlogic::TestCase

describe UserSessionsController do

  def mock_user_session(stubs = {})
    @mock_user_session ||= mock_model(UserSession, stubs)
  end

    describe "as an authentic user" do
      before :each do
        UserSession.stub(:find).and_return(mock_user_session)
#        mock_user_session.stub(:user).and_return(mock_user)
      end

      describe "GET new" do
        it "redirects to the root page" do
          get :new
          response.should redirect_to(root_url)
        end
      end
    end

    describe "posting to #create user_session" do
      describe "with valid parameters" do
        it "should redirect to the root" do
          post :create, { :user_session => { :id => "1", :email => "user@gmail.com", :password => "password" } }
          response.should redirect_to(root_url)
        end
      end
    end

    describe "post to #destroy user_session" do
      it "should destroy a current_user_session" do
        UserSession.stub(:find).with('42').and_return(mock_user_session)
        mock_user_session.should_receive(:destroy).and_return(mock_user_session)
        post :destroy_user_session, :user_session_id => '1'
      end
    end
end

