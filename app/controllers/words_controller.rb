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
    # code to figure out which post we're trying to update, then
    # actually update the attributes of that post.  Once that's
    # done, redirect us to somewhere like the Show page for that
    # post
  end

  def destroy
    @word = Word.find(params[:id])
    @word.destroy

    flash.notice="Word '#{@word.word_name}' was deleted"

    redirect_to words_path
  end

  def word_params
    allow = [:word_name, :descripton, :syntactical_category, :semantical_categories]
    params.require(:word).permit(allow)
  end
end
