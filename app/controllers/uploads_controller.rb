class UploadsController < ApplicationController
  
  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(params[:upload])
    if @upload.save
      flash[:notice] = 'Your Photo was successfully Uploaded.'
      redirect_to upload_url(@upload)     
    else
      render :action => :new
    end
  end
end
