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

    @word.save
    redirect_to categories_path_new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    # code to figure out which post we're trying to update, then
    # actually update the attributes of that post.  Once that's
    # done, redirect us to somewhere like the Show page for that
    # post
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