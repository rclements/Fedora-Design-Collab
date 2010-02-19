require File.dirname(__FILE__) + '/../spec_helper'

describe CommentsController do

  describe "Authenticated examples" do
    before(:each) do
      activate_authlogic
      
      @username = "bob"
      @password = "bobby"
      @user = User.make(:username => @username, :password => @password, :password_confirmation => @password)
      create_user_session(@user)
    end

    describe "hitting #new" do
      before(:each) do
        @project = Project.make
        get :new, :project_id => @project.id
      end

      it { response.should be_success }
      it { response.should render_template("comments/new") }
      it "should assign @comment as a new Comment" do
        assigns(:comment).should be_a(Comment)
        assigns(:comment).id.should be_nil
      end
    end

    describe "posting to #create" do
      describe "with valid parameters" do
        before(:each) do
          @project = Project.make
          post :create, { :project_id => @project.id, :comment => { :comment => "blah blah blah" }, :refurl => "/"}
        end

        it "should redirect to the project path" do
          response.should redirect_to("/")
        end

        it "should create and assign a @comment" do
          assert assigns(:comment)
        end
      end

      describe "with invalid parameters" do
        before(:each) do
          @project = Project.make
          post :create, { :project_id => @project.id, :comment => { :comment => nil } }
        end

        it { response.should render_template("new") }

      end
    end
  end
end
