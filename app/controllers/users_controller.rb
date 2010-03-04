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
    @projects  = @user.projects.paginate(:page => params[:page], :order => 'created_at DESC', :per_page => 5)
    @proposals = @user.proposals.paginate(:page => params[:page], :order => 'created_at DESC', :per_page => 5)
    @comments  = @user.comments.paginate(:page => params[:page], :order => 'created_at DESC', :per_page => 5)

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
