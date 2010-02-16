require File.dirname(__FILE__) + '/../spec_helper'

describe ProjectsController do

  describe "Authenticated examples" do
    before(:each) do
      activate_authlogic
      UserSession.make User.make
    end

    describe "hitting #index" do
      before(:each) do
        get :index
      end

      it { response.should be_success }
      it { response.should render_template("projects/index") }
      it "should assign @projects as an array" do
        assigns(:projects).should be_a(Array)
      end
    end

    describe "hitting #show with an id" do
      before(:each) do
        build :project
        get :show, { :id => @project.id }
      end

      it { response.should be_success }
      it { response.should render_template("projects/show") }
      it "should assign @project" do
        assigns(:project).should be_a(Project)
      end
    end

    describe "hitting #new" do
      before(:each) do
        get :new
      end

      it { response.should be_success }
      it { response.should render_template("projects/new") }
      it "should assign @project as a new Project" do
        assigns(:project).should be_a(Project)
        assigns(:project).id.should be_nil
      end
    end

    describe "posting to #create" do
      before(:each) do
        @old_project_count = Project.count
      end

      describe "with valid parameters" do
        before(:each) do
          post :create, { :project => { :title => "foo", :description => "bar" } }
        end

        it "should redirect to the project path" do
          response.should redirect_to(project_path(Project.last.id))
        end

        it "should create and assign a @project" do
          assigns(:project).should be_a(Project)
          assigns(:project).id.should_not be_nil
        end

        it "should change the project count by 1" do
          lambda do
            post :create, { :project => { :title => "foo", :description => "bar" } }
          end.should change(Project, :count).by(1)
        end
      end

      describe "with invalid parameters" do
        before(:each) do
          post :create, { :project => { :title => "foo", :description => "bar" } }
          @new_project_count = Project.count
        end

        it { response.should render_template("projects/new") }

        it "should assign a @project that has errors" do
          assigns(:project).should be_a(Project)
        end
      end
    end

    describe "PUTing to #update" do
      before(:each) do
        build :project
      end

      describe "successfully" do
        before(:each) do
          put :update, { :id => @project.id, :project => { :title => "foo" } }
        end

        it { response.should redirect_to(project_path(@project))}
      end

      describe "unsuccessfully" do
        before(:each) do
          put :update, { :id => @project.id, :project => { :title => nil } }
        end

        it { response.should render_template("projects/edit") }
      end
    end

    describe "DELETEing to #destroy" do
      before(:each) do
        build :project
      end

      describe "successfully" do
        before(:each) do
          class Project < ActiveRecord::Base
            def destroy
              super
            end
          end
          delete :destroy, { :id => @project.id }
        end

        it { response.should redirect_to(projects_path) }
      end

      describe "unsuccessfully" do
        before(:each) do
          class Project < ActiveRecord::Base
            def destroy
              false
            end
          end
          delete :destroy, { :id => @project.id }
        end

        it { response.should render_template("projects/show") }
      end
    end
  end
end
