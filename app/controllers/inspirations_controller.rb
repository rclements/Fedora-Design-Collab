class InspirationsController < ApplicationController
  before_filter :require_user, :only => [:new, :create]
  before_filter :ensure_project_id, :only => [:new, :create]
  before_filter :load_inspiration, :only => [:show, :edit, :update, :destroy]
  before_filter :load_new_inspiration, :only => [:new, :create]
  before_filter :load_inspiration_images, :only => [:show, :new]

  protected

  def ensure_project_id
    unless params[:project_id]
      flash[:error] = "You shouldn't be here without a project id."
      redirect_back_or_default("/") and return
    end
  end

  def load_inspiration
    @inspiration = Inspiration.find(params[:id])
  end

  def load_new_inspiration
    @inspiration = Inspiration.new(params[:inspiration])
    @inspiration.project_id = params[:project_id]
  end

  def load_inspiration_images
    @inspiration_images = @inspiration.inspiration_images
  end

  public

  def new
  end

  def create
    if params[:inspiration_image].present?
      @inspiration.inspiration_images.build(:image_file => params[:inspiration_image])
    end
    if @inspiration.save
      flash[:notice] = "Inspiration created successfully."
      redirect_to @inspiration.project
    else
      flash.now[:error] = "There was a problem creating the inspiration."
      render :action => :new
    end
  end

  def edit
  end

  def update
    if params[:inspiration_image].present?
      @inspiration.inspiration_images.build(:image_file => params[:inspiration_image])
    end
    if @inspiration.update_attributes(params[:inspiration])
      flash[:notice] = "The inspiration was successfully edited."
      redirect_to @inspiration.project
    else
      flash.now[:notice] = "There was a problem updating the project."
      render :action => 'edit'
    end
  end

  def show
  end

  def destroy
    @project = @inspiration.project
    if @inspiration.destroy
      flash[:notice] = "The inspiration was deleted."
      redirect_to @project
    else
      flash.now[:error] = "There was a problem deleting the inspiration."
      render :action => 'show'
    end
  end
end
