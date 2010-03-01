class VotesController < ApplicationController
  before_filter :load_voteable, :only => [:create]

  protected
  def load_voteable
    # We require these three params to handle a vote
    unless params[:voteable_type] && params[:voteable_id] && params[:vote]
      flash[:error] = "Something went wrong."
      redirect_back_or_default("/")
    end
    # We require that the vote param be either "true" or "false"
    # "true" is a vote for, "false" is a vote against
    unless %w(true false).include?(params[:vote])
      flash[:error] = "Something went wrong."
      redirect_back_or_default("/")
    end
    @vote = params[:vote].downcase == "true"
    # This will turn "proposal" into Proposal
    klass = params[:voteable_type].camelize.constantize
    @voteable = klass.find params[:voteable_id]
  end

  public
  def create
    # First, we kill this user's other votes for this voteable
    current_user_votes = Vote.for_voter(current_user).for_voteable(@voteable)
    current_user_votes.map(&:destroy)
    # Then, we vote with the new vote
    current_user.vote(@voteable, @vote)
    flash[:notice] = "Your vote has been cast."
    redirect_to_ref_url 
  end
end
