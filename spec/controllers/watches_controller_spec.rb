require File.dirname(__FILE__) + '/../spec_helper'

describe WatchesController do
  describe "A logged-in user" do
    before(:each) do
      activate_authlogic
      inc_ary = watch_with_watcher
      @project = inc_ary[0]
      @user = inc_ary[1]
      create_user_session(@user)
    end
  
    describe "posting to create" do
    end
  end
end
 
