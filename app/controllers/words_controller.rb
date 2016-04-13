class WordsController < ApplicationController

  def index
    @word = Word.all
  end

  def show
    @word = Word.find(params[:id])
  end

  def new
    # very simple code to create an empty post and send the user
    # to the New view for it (new.html.erb), which will have a
    # form for creating the post
  end

  def create
    @word = Word.new(params[:article])

    @word.save
    flash[:success] = "Word successfully saved!"
    redirect_to @word
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
    # very simple code to find the post we're referring to and
    # destroy it.  Once that's done, redirect us to somewhere fun.
  end
end
