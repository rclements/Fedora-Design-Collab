class CommentsController < ApplicationController
  before_filter :load_comment, :only => [:show, :edit, :update, :destroy]
  before_filter :load_new_comment, :only => [:new, :create]

  protected
  def load_new_comment
    @comment = Comment.new(params[:comment])
  end

  public
  def new
  end

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment])
    @comment.creator = current_user
    if @comment.save
      flash[:notice] = "Comment created successfully."
      redirect_to_ref_url
    else
      flash.now[:error] = "There was a problem creating the comment."
      render :action => :new
    end
  end

  private
  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
  end
end
