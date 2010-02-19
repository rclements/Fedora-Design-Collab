require File.dirname(__FILE__) + '/../spec_helper'

describe ProposalsController do

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
      it { response.should render_template("proposals/new") }
      it "should assign @proposal as a new Proposal" do
        assigns(:proposal).should be_a(Proposal)
        assigns(:proposal).id.should be_nil
      end
    end

    describe "posting to #create" do
      describe "with valid parameters" do
        before(:each) do
          @project = Project.make
          post :create, { :project_id => @project.id, :proposal => { :content => "aasdgsdgr" } }
        end

        it "should redirect to the proposal path" do
          response.should redirect_to(project_path(assigns(:proposal).project))
        end

        it "should create and assign a @proposal" do
          assert assigns(:proposal)
        end

      end
      describe "with invalid parameters" do
        before(:each) do
          @project = Project.make
          post :create, { :project_id => @project.id, :proposal => {:content => nil } }
        end
        it { response.should render_template("proposals/new") }

      end
    end

    describe "PUTing to #update" do
      before(:each) do
        @proposal = Proposal.make
      end

      describe "successfully" do
        before(:each) do
          put :update, { :id => @proposal.id, :proposal => { :content => "stuff said" } }
        end
        
        it { response.should redirect_to(project_path(@proposal.project))}
      end

      describe "unsuccessfully" do
        before(:each) do
          put :update, { :id => @proposal.id, :proposal => { :content => nil } }
        end

        it { response.should render_template("edit") }
      end
    end

    describe "DELETEing to #destroy" do
      before(:each) do
        @proposal = Proposal.make
        @project = @proposal.project
      end

      describe "successfully" do
        before(:each) do
          class Proposal < ActiveRecord::Base
            def destroy
              super
            end
          end
          delete :destroy, { :id => @proposal.id }
        end

        it { response.should redirect_to(project_path(@project)) }
      end

      describe "unsuccessfully" do
        before(:each) do
          class Proposal < ActiveRecord::Base
            def destroy
              false
            end
          end
          delete :destroy, { :id => @proposal.id }
        end

        it { response.should redirect_to("/") }
      end
    end
  end
end
