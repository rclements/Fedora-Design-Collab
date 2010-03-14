class WatchesController < ApplicationController
  before_filter :load_project, :only => [:create, :destroy]

  protected
  def load_project
    @project = Project.find(params[:id])
  end

  public
  def create
    current_user.has_role!(:watcher, @project)
    flash[:notice] = "Watch has been added."
    redirect_to_ref_url
  end

  def destroy
    current_user.has_no_role!(:watcher, @project)
    flash[:notice] = "Watch has been removed."
    redirect_to_ref_url
  end
end
