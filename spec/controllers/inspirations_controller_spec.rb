require File.dirname(__FILE__) + '/../spec_helper'

describe InspirationsController do
  integrate_views

  describe "Authenticated examples" do
    before(:each) do
      activate_authlogic
      
      @username = "bob"
      @password = "bobby"
      @user = User.make(:username => @username, :password => @password, :password_confirmation => @password)
      create_user_session(@user)
    end

    describe "hitting #new without a project_id" do
      before :each do
        get :new
      end

      it { response.should redirect_to("/") }
    end


    describe "hitting #new" do
      before(:each) do
        @project = Project .make
        get :new, :project_id => @project.id
      end

      it { response.should be_success }
      it { response.should render_template("inspirations/new") }
      it "should assign @inspiration as a new Inspiration" do
        assigns(:inspiration).should be_a(Inspiration)
        assigns(:inspiration).id.should be_nil
      end
    end

    describe "posting to #create" do
      describe "with valid parameters" do
        before :each do
          @project = Project.make
          post :create, { :project_id => @project.id, :inspiration => { :description => "asdf" } }
        end

        it "should redirect to the inspiration path" do
          response.should redirect_to(project_path(assigns(:inspiration).project))
        end
      end
      
      describe "with invalid parameters" do
        before :each do
          @project = Project.make
          post :create, { :project_id => @project.id, :inspiration => { :description => nil } }
        end
        it { response.should render_template("inspirations/new") }
      end
    end
  end
end
