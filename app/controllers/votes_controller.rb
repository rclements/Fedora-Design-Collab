class VotesController < ApplicationController
  before_filter :find_votes_for_my_scope, :only => [:index]
  before_filter :login_required, :only => [:new, :edit, :destroy, :create, :update]
  before_filter :must_own_vote, :only => [:edit, :destroy, :update]
  before_filter :not_allowed, :only => [:edit, :update, :new]
 
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @votes }
    end
  end
 
  def show
    @voteable = Vote.find(params[:id])
 
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @vote }
    end
  end
 
  def new
  end
 
  def edit
  end
 
  def create
    @voteable = Voteable.find(params[:quote_id])
    
    respond_to do |format|
      if current_user.vote(@voteable, params[:vote])
        format.rjs { render :action => "create", :vote => @vote }
        format.html { redirect_to([@voteable.user, @voteable]) }
        format.xml { render :xml => @voteable, :status => :created, :location => @voteable }
      else
        format.rjs { render :action => "error" }
        format.html { render :action => "new" }
        format.xml { render :xml => @vote.errors, :status => :unprocessable_entity }
      end
    end
  end
 
  def update
  end
  
  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy
 
    respond_to do |format|
      format.html { redirect_to(user_votes_url) }
      format.xml { head :ok }
    end
  end
 
  private
  def find_votes_for_my_scope
    if params[:voteable_id]
      @votes = Vote.for_voteable(Voteable.find(params[:voteable_id])).descending
    elsif params[:user_id]
      @votes = Vote.for_voter(User.find(params[:user_id])).descending
    else
      @votes = []
    end
  end
 
  def must_own_vote
    @vote ||= Vote.find(params[:id])
    @vote.user == current_user || ownership_violation
  end
 
  def ownership_violation
    respond_to do |format|
      flash[:notice] = 'You cannot edit or delete votes that you do not own!'
      format.html do
        redirect_to user_path(current_user)
      end
    end
  end
 
end
