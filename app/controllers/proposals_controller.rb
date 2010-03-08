class ProposalsController < ApplicationController
  before_filter :require_user, :only => [:new, :create]
  before_filter :ensure_project_id, :only => [:new, :create]
  before_filter :load_proposal, :only => [:show, :edit, :update, :destroy]
  before_filter :load_new_proposal, :only => [:new, :create]
  before_filter :load_proposal_images, :only => [:show, :new]
  before_filter :load_file_attachments, :only => [:show, :new, :create]

  protected
  def ensure_project_id
    unless params[:project_id]
      flash[:error] = "You shouldn't be here without a project id."
      redirect_back_or_default("/") and return
    end
  end

  def load_proposal
    @proposal = Proposal.find(params[:id])
  end

  def load_new_proposal
    @proposal = Proposal.new(params[:proposal])
    @proposal.project_id = params[:project_id]
    @proposal.creator = current_user
  end
    
  def load_proposal_images
    @proposal_images = @proposal.proposal_images
  end
  
  def load_file_attachments
    @file_attachments = @proposal.file_attachments
  end

  public
  def new
  end

  def show
  end

  def create
    if params[:proposal_image].present?
      @proposal.proposal_images.build(:image_file => params[:proposal_image])
    end
    if @proposal.save
      flash[:notice] = "Proposal created successfully."
      redirect_to proposal_path(@proposal.project.id)
    else
      flash.now[:error] = "There was a problem creating the proposal."
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @proposal.update_attributes(params[:proposal])
      flash[:notice] = "The proposal was successfully edited."
      redirect_to @proposal.project
    else
      flash.now[:notice] = "There was a problem updating the proposal."
      render :action => 'edit'
    end
  end

  def destroy
    @project = @proposal.project
    if @proposal.destroy
      flash[:notice] = "The proposal was deleted."
      redirect_to @project
    else
      flash[:error] = "There was a problem deleting the proposal."
      redirect_to "/"
    end
  end
end
