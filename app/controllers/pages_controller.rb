class PagesController < ApplicationController
  before_filter :load_projects
  before_filter :load_project, :only => [:show, :edit, :update, :destroy]

  protected
  def load_projects
    @projects = Project.all
    @projects  = @current_user.projects.paginate(:page => params[:projects_page], :order => 'created_at DESC', :per_page => 5)
  end

  def load_project
    @project = Project.find(params[:id])
    @project.creator = current_user
  end

  public
  def index
  end

  def show
  end
end

  

