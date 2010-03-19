class FileAttachmentsController < ApplicationController
  before_filter :redirect_if_no_proposal, :only => [:new, :create]
  before_filter :load_new_file_attachment, :only => [:new, :create]
  before_filter :load_file_attachment, :only => [:show]

  protected
  def redirect_if_no_proposal
    unless params[:proposal_id]
      redirect_to "/"
    end
  end

  def load_new_file_attachment
    @file_attachment = FileAttachment.new(params[:file_attachment])
    @file_attachment.proposal_id = params[:proposal_id]
  end

  def load_file_attachment
    @file_attachment = FileAttachment.find(params[:id])
  end

  public
  def show
    send_file(@file_attachment.attachment_file.path, :disposition => 'attachment')
  end

  def new
  end

  def create
    if @file_attachment.save
      flash[:notice] = "File Attachment created successfully."
      redirect_to projects_path
    else
      flash.now[:error] = "There was a problem saving the image."
      render :action => :new
    end
  end
end
