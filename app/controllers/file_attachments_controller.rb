class FileAttachmentsController < ApplicationController
  before_filter :load_new_file_attachment, :only => [:new, :create]
  before_filter :load_file_attachment, :only => [:show]

  protected
  def load_new_file_attachment
    @file_attachment = FileAttachment.new(params[:file_attachment])
    @file_attachment.proposal_id = params[:proposal_id]
  end

  def load_file_attachment
    @file_attachment = FileAttachment.find(params[:id])
  end

  public
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

  def show
    debugger
    send_file("#{RAILS_ROOT}/public/system/attachment_files/"+@file_attachment.attachment_file_file_name, :disposition => 'attachment', :encoding => 'utf8', :type => @file_attachment.attachment_file_file_content_type, :filename => URI.encode(@file_attachment.attachment_file_file_name))
  end

  def save_upload(upload)
    self.origial_filename = sanitize_file_name(upload.original_filename)
    self.new_filename = unique_filename
    File.open(absolute_path, "wb") { |f| f.write(upload.read) }
  end

  def save_file
    if params[:file_attachment] != nil
      file_attachment = FileAttachment.new
      file_attachment.save_upload(params[:file_attachment])
    end
  end

  private
  def absolute_path
    File.join(Rails.root, 'public/system/attachment_files', self.new_filename)
  end

  def sanitize_filename(filename)
    File.basename(filename).gsub(/[^\w\.\_]/,'_')
  end

  def unique_filename
    Time.now.strftime("%m%d%Y%H%M%S").to_s + "-#{self.original_filename}"
  end
end
