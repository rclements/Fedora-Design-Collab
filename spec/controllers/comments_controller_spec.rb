require File.dirname(__FILE__) + '/../spec_helper'

describe CommentsController do
  integrate_views

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
        describe "and a refurl param" do
          before(:each) do
            @project = Project.make
            post :create, { :project_id => @project.id, :comment => { :comment => "blah blah blah" }, :refurl => "/"}
          end

          it "should redirect to the refurl path" do
            response.should redirect_to("/")
          end

          it "should create and assign a @comment" do
            assert assigns(:comment)
          end
        end

        describe "and no refurl param" do
          before(:each) do
            @project = Project.make
            post :create, { :project_id => @project.id, :comment => { :comment => "blah blah blah" } }
          end

          it "should redirect to the root path" do
            response.should redirect_to(root_path)
          end
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

  describe "without being logged in" do
    describe "getting #index" do
      before(:each) do
        get :index
      end

      it{ response.should redirect_to(login_url) }
    end
  end
end
