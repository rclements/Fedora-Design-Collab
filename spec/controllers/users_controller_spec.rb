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

     describe "posting to #create" do
        describe "with valid parameters" do
          it "should redirect to the root" do
            post :create, { :user => { :id => "1", :username => "examplename", :email => "example@gmail.com", :password => "password", :password_confirmation => "password" } }
            response.should redirect_to(root_url)
          end
        end

        describe "with invalid parameters" do
          before :each do
            @user = User.make
            post :create, { :user => { :username => nil, :email => nil, :password => nil, :password_confirmation => nil } }
          end

          it { response.should render_template("users/new") }
        end
      end

    describe "a logged in user" do
      before(:each) do
        activate_authlogic
        @logged_in_user = User.make
        create_user_session(@logged_in_user)
      end

     describe "GET show" do
        before :each do
          @user = User.make
          get :show, :id => @user.id
        end

        it { response.should be_success }
        it { response.should render_template(:show) }
      end

      describe "GET edit" do
        before :each do
          @user = User.make
          get :edit
        end

        it {response.should be_success }
        it { response.should render_template("users/edit") }
        it "should assign @user" do
          assigns(:current_user).should be_a(User)
        end
      end

      describe "posting to #update" do
        before :each do
          @user = User.make
          post :update, { :user => { :id => "1", :username => 'jsmith', :password => 'password', :password_confirmation => 'password' } }
        end

        it { response.should redirect_to(root_url) }

        describe "unsuccessfully" do
          before :each do
            post :update, { :user => { :username => nil, :password => nil, :password_confirmation => nil } }
          end

          it { response.should render_template(:edit) }
        end
      end
    end
end
