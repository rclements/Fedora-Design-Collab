class ProjectsController < ApplicationController
  before_filter :load_projects
  before_filter :load_project, :only => [:show, :edit, :update, :destroy]
  before_filter :load_new_project, :only => [:new, :create]

  protected
  def load_projects
    @projects = Project.all
    @projects = @projects.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 10 
  end

  def load_project
    @project = Project.find(params[:id])
  end

  def load_new_project
    @project = Project.new(params[:project])
  end

  public
  def index
  end

  def new
  end

  def create
    if @project.save
      flash[:notice] = "Project created successfully."
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
  end
end
