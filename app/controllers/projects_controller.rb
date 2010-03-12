class ProjectsController < ApplicationController
  before_filter :load_projects
  before_filter :load_project, :only => [:show, :edit, :update, :destroy]
  before_filter :load_new_project, :only => [:new, :create]
  
  access_control do
    #allow :admin
    allow logged_in, :to => [:show, :new, :create, :index]
    allow :owner, :manager, :of => :project, :to => [:create, :show, :destroy, :edit, :update]
  end

  protected
  def load_projects
    @projects = Project.all
  end

  def load_project
    @project = Project.find(params[:id])
  end

  def load_new_project
    @project = Project.new(params[:project])
  end

  public
  def index
    if params[:sort_by]  == "oldest"
      @search = Project.ascend_by_created_at.search(params[:search])
    else
      @search = Project.descend_by_created_at.search(params[:search])
    end
    @projects_count = @search.count
    @projects = @search.all.paginate(:page => params[:page], :per_page => 5)
    @sort_message = params[:sort_by].capitalize if params[:sort_by]
  end

  def new
  end

  def create
    @project.creator = current_user
    if @project.save
      flash[:notice] = "Project created successfully."
      current_user.has_role!(:owner, @project)
      redirect_to @project
    else
      flash.now[:error] = "There was a problem creating the project."
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @project.update_attributes(params[:project])
      flash[:notice] = "The project was successfully edited."
      redirect_to :action => 'show', :id => @project
    else
      flash.now[:notice] = "There was a problem updating the project."
      render :action => 'edit'
    end
  end

  def destroy
    if @project.destroy
      flash[:notice] = "The project was deleted."
      redirect_to projects_path
    else
      flash.now[:error] = "There was a problem deleting the project."
      render :action => 'show'
    end
  end

  def show
    @proposal = Proposal.find(params[:id])
  end
end
