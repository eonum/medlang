class WordsController < ApplicationController
  require 'will_paginate/array'
  helper MultiLanguageText

  def index
    @words = Word.where({:"name_#{locale}".exists => true})
    # natural_sort_by is needed because otherwise you get in trouble with the german umlauts
    @words = @words.natural_sort_by{|word| word.name_de}.paginate(:page => params[:page], :per_page => 15)
  end

  def show
    @word = Word.find(params[:id])
  end

  def new
   @word = Word.new
  end

  def create
    @word = Word.new(word_params)
    @categories = Category.all
    puts @word

    respond_to do |format|
      if @word.save
        format.html { redirect_to @word, notice: t("word_create_success") }
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
    @word = Word.find params[:id]

    respond_to do |format|
      if @word.update(word_params)
        format.html { redirect_to @word, notice: t("word_update_success") }
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
    flash[:notice] = t(:delete_confirmation)
    redirect_to words_path
  end

  def word_params
    allow = [:name_de, :name_en, :description_de, :description_en, :syntactical_category, :semantical_categories_ids => []]
    params.require(:word).permit(allow)
  end

  def remove_vowels(array)
    array.each do |arr|
      arr.name_de.gsub(/[äöü]/) do |match|
        case match
          when "ä"
            'ae'
          when "ö"
            'oe'
          when "ü"
            'ue'
        end
      end
    end
  end
end
