class PagesController < ApplicationController
  before_filter :load_projects, :only => [:home]

  protected
  def load_projects
    @my_projects = @current_user.projects.paginate(:page => params[:my_projects_page], :order => 'projects.created_at DESC', :per_page => 5)
    @project_watches = @current_user.project_watches.paginate(:page => params[:project_watches_page], :order => 'roles_users.created_at DESC', :per_page => 5)
  end

  public
  def index
  end
end
