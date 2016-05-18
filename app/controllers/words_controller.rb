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

    respond_to do |format|
      if @word.save
        format.html { redirect_to @word, notice: 'User was successfully created.' }
        format.json { render :index, status: :created, location: @word }
      else
        format.html { render :new }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @word = Word.find(params[:id])
  end

  def update
    respond_to do |format|
      if @word.update(user_params)
        format.html { redirect_to @word, notice: 'User was successfully updated.' }
        format.json { render :index, status: :ok, location: @word }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end

    end
  end

  def destroy
    @word = Word.find(params[:id])
    @word.destroy
    flash.notice= "Word #{@word.name_de} was deleted"
    redirect_to words_path
  end

  def word_params
    allow = [:name_de, :description_de, :syntactical_category_de, {:semantical_categories_de => []}]
    params.require(:word).permit(allow)
  end
end
