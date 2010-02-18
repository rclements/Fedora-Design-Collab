class InspirationsController < ApplicationController
  before_filter :load_inspiration
  before_filter :load_inspiration, :only => [:show, :edit, :update, :destroy]
  before_filter :load_new_inspiration, :only => [:new, :create]

  protected
  def load_inspirations
    @inspirations = Inspirations.all
  end

  def load_inspiration
    @inspiration = Inspiration.find(params[:id])
  end

  def load_new_inspiration
    @inspiration = Inspiration.new(params[:inspiration])
  end

  public
  def index
  end

  def new
  end

  def create
    if @inspiration.save
      flash[:notice] = "Inspiration created successfully."
      redirect_to @inspiration
    else
      flash.now[:error] = "There was a problem creating the inspiration."
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @inspiration.update_attributes(params[:inspiration])
      flash[:notice] = "The inspiration was successfully edited."
      redirect_to :action => 'show', :id => @inspiration
    else
      flash.now[:notice] = "There was a problem updating the inspiration."
      render :action => 'edit'
    end
  end

  def destroy
    if @inspiration.destroy
      flash[:notice] = "The inspiration was deleted."
      redirect_to inspirations_path
    else
      flash.now[:error] = "There was a problem deleting the inspiration."
      render :action => 'show'
    end
  end

  def show
  end
end
