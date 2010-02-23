require File.dirname(__FILE__) + '/../spec_helper'

describe RefurlHelper do

  describe "redirect to refurl" do
    before :each do
      if params[:refurl]
        response.should redirect_to(params[:refurl])
      end
    end
    
   # describe "unsuccessfully" do
   #   it "should redirect to the root" do
   #     response.should redirect_to("/")
   #   end
   # end
  end
end
