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

    describe "hitting #index" do
      before(:each) do
        get :index
      end

      it { response.should be_success }
      it { response.should render_template("inspirations/index") }
      it "should assign @inspirations as an array" do
        assigns(:inspirations).should be_a(Array)
      end
    end

    describe "hitting #show with an id" do
      before(:each) do
        @inspiration = Inspiration.make
        get :show, { :id => @inspiration.id }
      end

      it { response.should be_success }
      it { response.should render_template("inspirations/show") }
      it "should assign @inspiration" do
        assigns(:inspiration).should be_a(Inspiration)
      end
    end

    describe "hitting #new" do
      before(:each) do
        get :new
      end

      it { response.should be_success }
      it { response.should render_template("inspirations/new") }
      it "should assign @inspiration as a new Inspiration" do
        assigns(:inspiration).should be_a(Inspiration)
        assigns(:inspiration).id.should be_nil
      end
    end

    describe "posting to #create" do
      before(:each) do
        @old_inspiration_count = Inspiration.count
      end

      describe "with valid parameters" do
        before(:each) do
          post :create, { :inspiration => { :title => "foo", :description => "bar" } }
        end

        it "should redirect to the inspiration path" do
          response.should redirect_to(inspiration_path(Inspiration.last.id))
        end

        it "should create and assign a @inspiration" do
          assigns(:inspiration).should be_a(Inspiration)
          assigns(:inspiration).id.should_not be_nil
        end

        it "should change the inspiration count by 1" do
          lambda do
            post :create, { :inspiration => { :title => "foo", :description => "bar" } }
          end.should change(Inspiration, :count).by(1)
        end
      end

      describe "with invalid parameters" do
        before(:each) do
          post :create, { :inspiration => {:description => "bar" } }
        end

        it { response.should render_template("inspiration/new") }

        it "should assign a @inspiration that has errors" do
          assigns(:inspiration).should be_a(Inspiration)
        end
      end
    end

    describe "PUTing to #update" do
      before(:each) do
        @inspiration = Inspiration.make
      end

      describe "successfully" do
        before(:each) do
          put :update, { :id => @inspiration.id, :inspiration => { :title => "foo" } }
        end

        it { response.should redirect_to(inspiration_path(@inspiration))}
      end

      describe "unsuccessfully" do
        before(:each) do
          put :update, { :id => @inspiration.id, :inspiration => { :title => nil } }
        end

        it { response.should render_template("inspirations/edit") }
      end
    end

    describe "DELETEing to #destroy" do
      before(:each) do
        @inspiration = Inspirations.build
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

        it { response.should redirect_to(inspirations_path) }
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

        it { response.should render_template("inspirations/show") }
      end
    end
  end
end
