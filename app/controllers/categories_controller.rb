class CategoriesController < ApplicationController
  helper MultiLanguageText

  def index
    @category = Category.where(language: locale)
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
    Category.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to categories_path
  end

  def category_params
    allow = [:name,:description, :category_type, :language]
    params.require(:category).permit(allow)
  end
end