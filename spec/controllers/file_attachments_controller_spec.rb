require File.dirname(__FILE__) + '/../spec_helper'

describe FileAttachmentsController do
  describe "A logged-in user" do
    before(:each) do
      activate_authlogic
      
      @username = "bob"
      @password = "bobby"
      @user = User.make(:username => @username, :password => @password, :password_confirmation => @password)
      create_user_session(@user)
    end
   
    describe "hitting #new without a proposal_id" do
      before :each do
        get :new
      end

      it { response.should redirect_to("/") }
    end

    describe "hitting #new" do
      before(:each) do
        @project = Project.make
        get :new
      end

      it { response.should be_success }
      it { response.should render_template("file_attachments/new") }
      it "should assign @file_attachment as a new FileAttachment" do
        assigns(:file_attachment).should be_a(FileAttachment)
        assigns(:file_attachment).id.should be_nil
      end
    end

    describe "posting to #create" do
      describe "with valid parameters" do
        before(:each) do
          @project = Project.make
          post :create, { :proposal_id => @proposal.id, :file_attachment => { :image_file_file_name => "aasdgsdgr" } }
        end

        it "should redirect to the root path" do
          response.should redirect_to("/")
        end

        it "should create and assign a @file_attachment" do
          assert assigns(:file_attachment)
        end

      end

      describe "with invalid parameters" do
        before(:each) do
          @project = Project.make
          post :create, { :proposal_id => @proposal.id, :file_attachment => {:image_file_file_name => nil } }
        end
        it { response.should render_template("file_attachments/new") }
      end
    end
  end
end
