class WordsController < ApplicationController

  def index
    @word = Word.all
  end

  def show
    @word = Word.find(params[:id])
  end

  def new
   @word = Word.new
  end

  def create
    @word = Word.new(word_params)

    @word.save
    redirect_to words_path
  end

  def edit
    @word = Word.find(params[:id])
  end

  def update
    @word = Word.find(params[:id])

    if @word.update_attributes(word_params)
      flash[:notice] = 'successfully updated!'
      redirect_to words_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @word = Word.find(params[:id])
    @word.destroy
    flash.notice= "Word #{@word.name_de} was deleted"
    redirect_to words_path
  end

  def word_params
    allow = [:name_de, :description_de, :syntactical_category_de, :semantical_categories_de]
    params.require(:word).permit(allow)
  end
end
