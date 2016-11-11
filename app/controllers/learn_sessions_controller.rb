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

    # select random 10 words from the Words stock. Later the user should be able bey themselves to select the amount of words
    @words = Word.where(language: locale)
    @random_Words = generate_random_array(@words, 10)
    @random_Words.each{|rw| @learn_session.words << rw} # maybe this value can get deleted later, but I keep it for the moment

    # all words have to go into the first box. Check the comments in learnSession model for more information
    @random_Words.each{|rw| @learn_session.box0 << rw}

    # shuffle is needed because otherwise you will always get the alphabetical oder
    @learn_session.box0 = @learn_session.box0.shuffle

    #for later, when the usermanagement works
    #@learn_session.user = current_user

    respond_to do |format|
      if @learn_session.save
        format.html { redirect_to learn_session_learn_path(@learn_session.id), notice: t('learnSession_create') }
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
    @choices = Array.new

    @merged_boxes = @learn_session.box0.shuffle + @learn_session.box1.shuffle + @learn_session.box2.shuffle +
        @learn_session.box3.shuffle

    params[:index_value] == nil ? @choices << @merged_boxes[0] : @choices << @merged_boxes[params[:index_value].to_i]

    random_choice = generate_random_array(@words, 4)
    random_choice[0..2].each do |rc|
        #this if else statement is to make sure the correct answer don't show up twice
      if rc.equal?(@choices[0])
        @choices << rc[3]
      else
        @choices << rc
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
    @merged_boxes = @learn_session.box0 + @learn_session.box1 + @learn_session.box2 + @learn_session.box3
    user_answer = Word.find_by(id: params[:user_answer])
    asked_word = Word.find_by(id: params[:asked_word])

    # this is the actual validation part of this method
    if asked_word.description == user_answer.description
      flash[:notice] = t('learnSession_learn_mode_answer_correct')

      # this part puts a word into the next box, if the user_answer is correct and delete it out of the old box
      case
        when @learn_session.box0.include?(asked_word)
          @learn_session.box1.push(asked_word)
          @learn_session.box0 = @learn_session.box0.reject{|w| w.id == asked_word.id}
        when @learn_session.box1.include?(asked_word)
          @learn_session.box2.push(asked_word)
          @learn_session.box1 = @learn_session.box1.reject{|w| w.id == asked_word.id}
        when @learn_session.box2.include?(asked_word)
          @learn_session.box3.push(asked_word)
          @learn_session.box2 = @learn_session.box2.reject{|w| w.id == asked_word.id}
        when @learn_session.box3.include?(asked_word)
          @learn_session.box4.push(asked_word)
          @learn_session.box3 = @learn_session.box3.reject{|w| w.id == asked_word.id}
      end

      @learn_session.save

      # this if statement checks, if the learn_session is completet (it's completed when all words are in box4)
      if @learn_session.box0.empty? && @learn_session.box1.empty? && @learn_session.box2.empty? &&
          @learn_session.box3.empty?
        # this is temporary, after a learn_session is completed the the application should root the user to a specific
        # site
        redirect_to root_path
      end
    else    # if the answer is wrong this part fires up
      flash[:notice] = " \" #{asked_word.name}\"" + t('means') + " \"#{asked_word.description}\"" +
          t('and_not') + " \"#{user_answer.description}\""
    end

    # this if else statement looks, that only valid valus are used, if it gets bigger than the lenght of the words array
    # it starts again at the beginning. The index needs to be changed bevor the boxes changes because otherwise you
    # will always have the problem to get the correct array.
    if @learn_session.box0 != nil
      params[:index_value].to_i >= (@learn_session.box0.size - 1) ? (params[:index_value] = 0) :
          (params[:index_value] = params[:index_value].to_i + 1)
    elsif @learn_session.box1 != nil
      params[:index_value].to_i >= (@learn_session.box1.size -1) ? (params[:index_value] = 0) :
          params[:index_value].to_i +=  1
    elsif @learn_session.box2 != nil
      params[:index_value].to_i >= (@learn_session.box2.size - 1) ? (params[:index_value] = 0) :
          params[:index_value].to_i += 1
    else @learn_session.box3 != nil
      params[:index_value].to_i >=  (@learn_session.box3.size - 1) ? (params[:index_value]= 0) :
          params[:index_value].to_i += 1
    end

    @merged_boxes = @learn_session.box0.shuffle + @learn_session.box1.shuffle + @learn_session.box2.shuffle +
        @learn_session.box3.shuffle

    redirect_to learn_session_learn_path(@learn_session.id, index_value: params[:index_value])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_learn_session
      @learn_session = LearnSession.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def learn_session_params
      params[:learn_session]
      params.require(:learn_session).permit(:user, :completed, :words_ids => [], :box0 => [], :box1 => [], :box2 => [],
                                            :box3 => [], :box4 => [])
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