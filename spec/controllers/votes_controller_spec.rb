require File.dirname(__FILE__) + '/../spec_helper'

describe VotesController do
  describe "a logged in user" do
    before(:each) do
      activate_authlogic
      inc_ary = create_project_with_owner
      @project = inc_ary[0]
      @user = inc_ary[1]
      create_user_session(@user)
      @proposal = Proposal.make
      @refurl = proposals_path(@proposal)
    end

    describe "voting a proposal up" do
      describe "successfully" do
        before(:each) do
          post :create, :voteable_type => "Proposal", :voteable_id => @proposal.id, :vote => "true", :refurl => @refurl
        end

        it { response.should redirect_to(@refurl) }
      end

      describe "unsuccessfully" do
        before(:each) do
          post :create, :voteable_type => "Proposal", :voteable_id => @proposal.id, :vote => "balls"
        end

        it { response.should redirect_to(root_path) }
      end
    end

    describe "voting a proposal down" do
      before(:each) do
        post :create, :voteable_type => "Proposal", :voteable_id => @proposal.id, :vote => "false", :refurl => @refurl
      end

      it { response.should redirect_to(@refurl) }

      describe "and then voting a proposal up" do
        before(:each) do
          post :create, :voteable_type => "Proposal", :voteable_id => @proposal.id, :vote => "true", :refurl => @refurl
        end

        it { response.should redirect_to(@refurl) }
      end
    end

    describe "try to vote but leave out param" do
      before :each do
        post :create, :voteable_type => "Proposal"
      end

      it { response.should redirect_to("/") }
    end
  end
end
