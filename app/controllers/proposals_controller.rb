class ProposalsController < ApplicationController
  before_filter :ensure_project_id, :only => [:new, :create]
  before_filter :load_proposal, :only => [:edit, :update, :destroy]
  before_filter :load_new_proposal, :only => [:new, :create]

  protected
    def ensure_project_id
    unless params[:project_id]
      flash[:error] = "You shouldn't be here without a project id."
      redirect_to "/" and return
    end
  end

  def load_proposal
    @proposal = Proposal.find(params[:id])
  end
  def load_new_proposal
    @proposal = Proposal.new(params[:proposal])
    @proposal.project_id = params[:project_id]
  end

  public

  def new
  end

  def create
    if @proposal.save
      flash[:notice] = "Proposal created successfully."
      redirect_to @proposal.project
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
      flash.now[:error] = "There was a problem deleting the proposal."
      render :action => '/'
    end
  end
end
