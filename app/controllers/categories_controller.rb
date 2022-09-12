class CategoriesController < ApplicationController

    load_and_authorize_resource except: :create
    before_action :set_category, only: %i[ show edit update destroy ]

  def index
    @category = Category.all
  end

  def show
    authorize! :read, @category
  end

  def new
    @category = Category.new()
     authorize! :read, @category
  end

  def create
    @category = Category.new(name: params[:category][:name])
    @category.save
    redirect_to root_path
  end

  def edit
     authorize! :read, @category
  end

  def update
    @category.update(name: params[:category][:name])
    redirect_to root_path
  end

  def  destroy   
    @category.destroy
    authorize! :read, @category
    redirect_to root_path
  end

  private

  def set_category    
    @category = Category.find(params[:id])
  end
  
end
