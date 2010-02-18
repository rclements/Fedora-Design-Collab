class CommentsController < ApplicationController
  before_filter :load_comment, :only => [:edit, :update, :destroy]
  before_filter :load_new_comment, :only => [:new, :create]

  protected

  def load_comment
    @comment = Comment.find(params[:id])
  end
  
  def load_new_comment
    @comment = Comment.new(params[:comment])
  end

  public
  def new
  end

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment])
    if @comment.save
      flash[:notice] = "Comment created successfully."
      redirect_to_ref_url
    else
      flash.now[:error] = "There was a problem creating the comment."
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @comment.update_attributes(params[:comment])
      flash[:notice] = "The comment was successfully edited."
      redirect_to @comment
    else
      flash.now[:notice] = "There was a problem updating the comment."
      render :action => 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:notice] = "The comment was deleted."
      redirect_to @project
    else
      flash.now[:error] = "There was a problem deleting the comment."
      render :action => '/'
    end
  end
  
  private
  
  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
