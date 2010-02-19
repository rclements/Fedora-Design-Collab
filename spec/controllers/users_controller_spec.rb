require File.dirname(__FILE__) + '/../spec_helper'
include Authlogic::TestCase

describe UsersController do

  def mock_user(stubs = {})
    @mock_user ||= mock_model(User, stubs)
  end

    describe "GET new" do
      before :each do
        User.stub(:new).and_return(mock_user)
      end

      it "assigns a new user as @user" do
        get :new
          User.stub(:new).and_return(mock_user)
        end
      
      it "renders the 'new' template" do
        get :new
        response.should render_template(:new)
      end
    end
    
    describe "GET show" do
      before :each do
        User.stub(:show).and_return(mock_user)
      end

    describe "GET edit" do
      before :each do
        @user = User.make
        get :edit
      end

      it "assigns user as @user" do
        get :edit
          User.stub(:edit).and_return(mock_user)
        end

      it "renders the 'edit' template" do
        response.should render_template(:edit)
      end
    end

    describe "posting to #create" do
      describe "with valid parameters" do
        it "should redirect to the root" do
          post :create, { :user => { :id => "1", :username => "examplename", :email => "example@gmail.com", :password => "password", :password_confirmation => "password" } }
          response.should redirect_to(root_url)
        end
      end

      describe "with invalid parameters" do
        before :each do
          post :create, { :user => { :username => nil, :email => nil, :password => nil, :password_confirmation => nil } }
        end

        it { response.should render_template("users/new") }
      end
    end

    describe "posting to #update" do
      describe "with valid parameters" do
        @valid_parameters = { 'username' => 'jsmith', 'email' => 'john.smith@example.com', 'password' => ' password' }
      end

      it "updates user as @user" do
        post :update, :user => @valid_parameters
        assigns[:user].should equal(mock_user)
        response.should redirect_to(root_url)
      end

      describe "with invalid parameters" do
        before :each do
          post :update, { :id => @user.id, :user => { :username => nil, :email => nil } }
        end

        it { response.should render_template("users/edit") }
      end
    end
  end
end
