class UsersController < ApplicationController
  before_filter :load_user, :only => [:show]
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:destroy, :edit, :update]

  protected
  def load_user
    @user = User.find params[:id]
  end

  public
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Registration Successful!"
      redirect_to root_url
    else
      render :action => :new
    end
  end
  
  def show
    @projects  = @current_user.projects.paginate(:page => params[:projects_page], :order => 'created_at DESC', :per_page => 5)
    @proposals = @current_user.proposals.paginate(:page => params[:proposals_page], :order => 'created_at DESC', :per_page => 5)
    @comments  = @current_user.comments.paginate(:page => params[:comments_page], :order => 'created_at DESC', :per_page => 5)

  end
 
  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to root_url
    else
      render :action => :edit
    end
  end
end
