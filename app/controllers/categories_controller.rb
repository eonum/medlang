class CategoriesController < ApplicationController
  def index
    @category = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    @category.save
    redirect_to categories_path
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(category_params)
      flash[:notice] = 'successfully updated!'
      redirect_to categories_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    # very simple code to find the post we're referring to and
    # destroy it.  Once that's done, redirect us to somewhere fun.
  end

  def category_params
    allow = [:name_de, :name_en, :description_de, :description_en, :type_de, :type_en]
    params.require(:category).permit(allow)
  end
end