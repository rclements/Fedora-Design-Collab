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

    describe "hitting #index" do
      before(:each) do
        get :index
      end

      it { response.should be_success }
      it { response.should render_template("proposals/index") }
      it "should assign @proposals as an array" do
        assigns(:proposals).should be_a(Array)
      end
    end

    describe "hitting #show with an id" do
      before(:each) do
        @proposal = Proposal.make
        get :show, { :id => @proposal.id }
      end

      it { response.should be_success }
      it { response.should render_template("proposals/show") }
      it "should assign @proposal" do
        assigns(:proposal).should be_a(Proposal)
      end
    end

    describe "hitting #new" do
      before(:each) do
        get :new
      end

      it { response.should be_success }
      it { response.should render_template("proposals/new") }
      it "should assign @proposal as a new Proposal" do
        assigns(:proposal).should be_a(Proposal)
        assigns(:proposal).id.should be_nil
      end
    end

    describe "posting to #create" do
      before(:each) do
        @old_proposal_count = Proposal.count
      end

      describe "with valid parameters" do
        before(:each) do
          post :create, { :proposal => { :title => "foo", :description => "bar" } }
        end

        it "should redirect to the proposal path" do
          response.should redirect_to(proposal_path(Proposal.last.id))
        end

        it "should create and assign a @proposal" do
          assigns(:proposal).should be_a(Proposal)
          assigns(:proposal).id.should_not be_nil
        end

        it "should change the proposal count by 1" do
          lambda do
            post :create, { :proposal => { :title => "foo", :description => "bar" } }
          end.should change(Proposal, :count).by(1)
        end
      end

      describe "with invalid parameters" do
        before(:each) do
          post :create, { :proposal => {:description => "bar" } }
        end

        it { response.should render_template("proposal/new") }

        it "should assign a @proposal that has errors" do
          assigns(:proposal).should be_a(Proposal)
        end
      end
    end

    describe "PUTing to #update" do
      before(:each) do
        @proposal = Proposal.make
      end

      describe "successfully" do
        before(:each) do
          put :update, { :id => @proposal.id, :proposal => { :title => "foo" } }
        end

        it { response.should redirect_to(proposal_path(@proposal))}
      end

      describe "unsuccessfully" do
        before(:each) do
          put :update, { :id => @proposal.id, :proposal => { :title => nil } }
        end

        it { response.should render_template("proposals/edit") }
      end
    end

    describe "DELETEing to #destroy" do
      before(:each) do
        @proposal = Proposals.make
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

        it { response.should redirect_to(proposals_path) }
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

        it { response.should render_template("proposals/show") }
      end
    end
  end
end
