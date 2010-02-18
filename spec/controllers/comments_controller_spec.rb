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
        get :new
      end

      it { response.should be_success }
      it { response.should render_template("comments/new") }
      it "should assign @comment as a new Comment" do
        assigns(:comment).should be_a(Comment)
        assigns(:comment).id.should be_nil
      end
    end

    describe "posting to #create" do
      before(:each) do
        @old_comment_count = Comment.count
      end

      describe "with valid parameters" do
        before(:each) do
          post :create, { :comment => { :comment => "blah blah blah" } }
        end

        it "should redirect to the comment path" do
          response.should redirect_to(ref_url)
        end

        it "should create and assign a @comment" do
          assigns(:comment).should be_a(Comment)
          assigns(:comment).id.should_not be_nil
        end

        it "should change the comment count by 1" do
          lambda do
             post :create, { :comment => { :comment => "blah blah blah" } }
          end.should change(Comment, :count).by(1)
        end
      end

      describe "with invalid parameters" do
        before(:each) do
          post :create, { :comment => { :comment => "blah blah blah" } }
        end

        it { response.should render_template("comments/new") }

        it "should assign a @comment that has errors" do
          assigns(:comment).should be_a(Comment)
        end
      end
    end

    describe "PUTing to #update" do
      before(:each) do
        @comment = Comment.make
      end

      describe "successfully" do
        before(:each) do
          put :update, { :id => @comment.id, :comment => { :comment => "blah blah blah" } }
        end

        it { response.should redirect_to(comment_path(@comment))}
      end

      describe "unsuccessfully" do
        before(:each) do
          put :update, { :id => @comment.id, :comment => { :comment => nil } }
        end

        it { response.should render_template("comments/edit") }
      end
    end

    describe "DELETEing to #destroy" do
      before(:each) do
        @comment = Comment.make
      end

      describe "successfully" do
        before(:each) do
          class Comment < ActiveRecord::Base
            def destroy
              super
            end
          end
          delete :destroy, { :id => @comment.id }
        end

        it { response.should redirect_to(projects_path) }
      end

      describe "unsuccessfully" do
        before(:each) do
          class Comment < ActiveRecord::Base
            def destroy
              false
            end
          end
          delete :destroy, { :id => @comment.id }
        end

        it { response.should render_template("comments.project_path") }
      end
    end
  end
end
