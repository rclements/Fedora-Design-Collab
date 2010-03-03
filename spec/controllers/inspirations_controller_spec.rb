require File.dirname(__FILE__) + '/../spec_helper'

describe InspirationsController do

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
          post :create, { :project_id => @project.id, :inspiration => { :title => "blah", :description => "asdf" } }
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

    describe "PUTing to #update" do
      before(:each) do
        @inspiration = Inspiration.make
      end

      describe "successfully" do
        before(:each) do
          put :update, { :id => @inspiration.id, :inspiration => { :title => "blah", :description => "stuff said about stuff" } }
        end
        
        it { response.should redirect_to(project_path(@inspiration.project))}
      end

      describe "unsuccessfully" do
        before(:each) do
          put :update, { :id => @inspiration.id, :inspiration => { :title => nil, :description => nil } }
        end

        it { response.should render_template("edit") }
      end
    end

    describe "DELETEing to #destroy" do
      before(:each) do
        @inspiration = Inspiration.make
        @project = @inspiration.project
      end

      describe "successfully" do
        before(:each) do
          class Inspiration < ActiveRecord::Base
            def destroy
              super
            end
          end
          delete :destroy, { :id => @inspiration.id }
        end

        it { response.should redirect_to(project_path(@project)) }
      end

      describe "unsuccessfully" do
        before(:each) do
          class Inspiration < ActiveRecord::Base
            def destroy
              false
            end
          end
          delete :destroy, { :id => @inspiration.id }
        end

        it { response.should redirect_to("/") }
      end
    end
  end
end
