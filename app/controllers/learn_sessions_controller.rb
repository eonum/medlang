class LearnSessionsController < ApplicationController
  before_action :set_learn_session, only: [:show, :edit, :update, :destroy]

  # GET /learn_sessions
  # GET /learn_sessions.json
  def index
    @learn_sessions = LearnSession.all
  end

  # GET /learn_sessions/1
  # GET /learn_sessions/1.json
  def show
    @learn_session = LearnSession.find(params[:id])
  end

  # GET /learn_sessions/new
  def new
    @learn_session = LearnSession.new
  end

  # GET /learn_sessions/1/edit
  def edit
  end

  # POST /learn_sessions
  # POST /learn_sessions.json
  def create
    @learn_session = LearnSession.new
    @number_of_words = params[:learn_session][:number_of_words].to_i
    @number_of_boxes = params[:learn_session][:number_of_boxes].to_i
    # intern we need a box more than the user want, because the last box is the "don't show those words again" box
    @number_of_boxes = @number_of_boxes + 1

    @number_of_boxes.times do |i|
      @learn_session.boxes[i] = Array.new
    end


    @words = Word.where(language: locale)
    @random_Words = generate_random_array(@words, @number_of_words )
    @random_Words.each{|rw| @learn_session.words << rw} # maybe this value can get deleted later, but I keep it for the moment

    # all words have to go into the first box. Check the comments in learnSession model for more information
    @random_Words.each{|rw| @learn_session.boxes[0] << [rw.id, rw.name, rw.description]}


    # shuffle is needed because otherwise you will always get the alphabetical oder
    @learn_session.boxes[0] = @learn_session.boxes[0].shuffle

    #for later, when the usermanagement works
    #@learn_session.user = current_user

    respond_to do |format|
      if @learn_session.save
        format.html { redirect_to learn_session_learn_path(@learn_session.id, asked_word: @learn_session.boxes[0][0]),
                                  notice: t('learnSession_create') }
        format.json { render :show, status: :created, location: @learn_session }
      else
        format.html { render :new }
        format.json { render json: @learn_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /learn_sessions/1
  # PATCH/PUT /learn_sessions/1.json
  def update
    respond_to do |format|
      if @learn_session.update(learn_session_params)
        format.html { redirect_to @learn_session, notice: t('learnSession_update') }
        format.json { render :show, status: :ok, location: @learn_session }
      else
        format.html { render :edit }
        format.json { render json: @learn_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /learn_sessions/1
  # DELETE /learn_sessions/1.json
  def destroy
    @learn_session.destroy
    respond_to do |format|
      format.html { redirect_to learn_sessions_url, notice: t('learnSession_delete') }
      format.json { head :no_content }
    end
  end

  # GET /learn_sessions/1/learn
  def learn
    @learn_session = LearnSession.find(params[:learn_session_id])

    # filling up the 2-D array choice
    @words = Word.where(language: locale)
    @choices = []
    @choices << params[:asked_word][2]

    random_choice = generate_random_array(@words, 4)
    random_choice[0..2].each do |rc|
        #this if else statement is to make sure the correct answer don't show up twice
      if rc.description.equal?(@choices[0])
        @choices << rc[3].description
      else
        @choices << rc.description
      end
    end

    # shuffle the arry because otherwise the correct answer will always at the first object in a array
    @choices.shuffle!

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @learn_session }
    end
  end

  def check_answer
    @learn_session = LearnSession.find(params[:learn_session_id])
    asked_word = Word.find_by(id: params[:asked_word][0])
    user_answer = Word.find_by(description: params[:user_answer])
    # with this index you know on which position the asked_word is in the box array. This is important for example
    # important if you want to assign the next word in the array to asked_word
    @index_asked_word = 0
    @learn_session.boxes.each do |box|
      box.each do |word|
        @index_asked_word = box.index(word) if word[2] == asked_word.description
      end
    end

    # this is the actual validation part of this method
    if asked_word.description == user_answer.description
      catch :exit_nested_loop do
        @learn_session.boxes.each do |box|
          box.each do |word|
            # its word[2] because word is a array of three values
            if word[2] == asked_word.description
              unless @learn_session.boxes.last.include?(word)
                index = @learn_session.boxes.index(box)
                @learn_session.boxes[index + 1] << [asked_word.id, asked_word.name, asked_word.description]
                box.reject!{|w| w[0] == asked_word.id }
                throw :exit_nested_loop
              end
            end
          end
        end
      end
      flash[:notice] = t('learnSession_learn_mode_answer_correct')

      @learn_session.save

      # this if statement checks, if the learn_session is completet (it's completed when all words are in box4)
      if @learn_session.boxes.last.size == @learn_session.words.size
        # this is temporary, after a learn_session is completed the the application should root the user to a specific
        # site
        flash[:notice] = t('learnSession_learn_gratulation_for_finishing_session')
        return redirect_to root_path
      end
    else    # if the answer is wrong this part fires up
      flash[:notice] = " \" #{asked_word.name}\"" + t('means') + " \"#{asked_word.description}\"" +
          t('and_not') + " \"#{user_answer.description}\""
    end

    # this nested loop takes care of iterating trough the all boxes and assigns a new value to params[:asked_word]
    # there's a catch and throw statement which escapes the loop at the point you have a new value for params[:asked_word]
    catch :exit_index_control do
      @learn_session.boxes.each do |box|
        if box.empty? == false
          # this elsif take care, that the user dosen't get asked the same word two times in a row if
          #  possible (it happens, when there is only one word left in the n-1 box)
          if box.length == 1  && asked_word.id == box[0][0] && @learn_session.boxes.index(box) <
              (@learn_session.boxes.length - 2) # minus 2 because length start counting at 1 and arrays at 0
            params[:asked_word] = @learn_session.boxes[@learn_session.boxes.index(box) + 1][0]
          elsif @index_asked_word >= (box.length - 1)
            params[:asked_word] = box[0]
          else
            params[:asked_word] = box[(@index_asked_word + 1)]
          end
          throw :exit_index_control
        end
      end
    end

    redirect_to learn_session_learn_path(@learn_session.id, asked_word: params[:asked_word])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_learn_session
      @learn_session = LearnSession.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def learn_session_params
      params[:learn_session]
      params.require(:learn_session).permit(:user, :completed, :words_ids => [] )
    end

  # take the array arr and picks the no_of_values from it and store it in a new array array_off_random_values
  # this method is needed because the sample method of Array doesn't care about duplicates
  def generate_random_array(arr, no_of_values )
    random_numbers = []
    array_of_random_values = []

    random_numbers = rand_n(no_of_values, arr.length)

    i = 0
    while i < no_of_values do
      array_of_random_values << arr[random_numbers[i]]
      i += 1
    end

    return array_of_random_values
  end

  # this method returns a array of unique numbers depending on how much numbers do you need
  # and how big the biggest value should be.
  def rand_n(n, max)
    randoms = Set.new
    loop do
      randoms << rand(max)
      return randoms.to_a if randoms.size >= n
    end
  end
end