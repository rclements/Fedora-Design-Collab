require File.dirname(__FILE__) + '/../spec_helper'
include Authlogic::TestCase
activate_authlogic

describe UserSessionsController do

  describe "without a logged-in user" do
    describe "trying to log in" do
      before(:each) do
        @user = User.make
      end
        
      it "should redirect to root" do
        post :create, :user_session => { :username => @user.username, :password => "password" } 
        response.should redirect_to(root_url)
      end
       
      describe "should redirect to :new if it fails" do
        post :create, :user_session => { :username => nil, :password => nil }
        it { response.should render_template(:new) }
      end
    end
  end

  describe "when logged in" do
    before(:each) do
      activate_authlogic
      
      @username = "bob"
      @password = "bobby"
      @user = User.make(:username => @username, :password => @password, :password_confirmation => @password)
      create_user_session(@user)
    end

    describe "when deleting the current session" do
      before(:each) do
        post :destroy
      end

      it "should redirect to login_path after user posts to destroy current_user_session" do
        response.should redirect_to(root_path)
      end
    end

    describe "when attempting to hit login again" do
      it "should redirect to the account_url" do
        post :create, :user_session => { :username => @user.username, :password => "password" } 
        response.should redirect_to(account_url)
      end
    end
  end
    
  describe "GET #new" do
     before(:each) do
       get :new
     end

    it { response.should be_success }
    it { response.should render_template(:new) }
    it "should assign @user_session as a new UserSession" do
      assigns(:user_session).should be_a(UserSession)
      assigns(:user_session).id.should be_nil
    end
  end
end
