require File.dirname(__FILE__) + '/../spec_helper'

describe ProposalsController do
  integrate_views


  describe "Without being logged in" do
    describe "hitting #new" do
      before(:each) do
        get :new
      end

      it { response.should redirect_to(new_user_session_path) }
    end

    describe "hitting #create" do
      before(:each) do
        post :create
      end

      it { response.should redirect_to(new_user_session_path) }
    end
  end

  describe "A logged-in user" do
    before(:each) do
      activate_authlogic
      create_user_session(@user)
    end
      it "should assign the role" do
        inc_ary = create_proposal_with_owner
        @proposal = inc_ary[0]
        @user = inc_ary[1]
      end


    describe "hitting #new without a project_id" do
      before :each do
        get :new
      end

      it { response.should redirect_to("/") }
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

    describe "posting to #create image" do
      before :each do
        @proposal = Proposal.make
        @proposal_image = mock("proposal_image")
        ProposalImage.stub(:new).and_return(@proposal_image)
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
