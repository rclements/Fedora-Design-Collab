class PagesController < ApplicationController
  before_filter :load_projects, :only => [:index]

  protected
  def load_projects
    @projects = Project.all
    @projects  = @current_user.projects.paginate(:page => params[:projects_page], :order => 'created_at DESC', :per_page => 5)
  end

  public
  def index
  end
end
