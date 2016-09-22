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
    @random_Words.each{|rw| @learn_session.words << rw}

    # filling up the 2-D array choice
    @random_Words.each{|rw| @learn_session.choices.push([rw.description])}
    @learn_session.choices.each do |choice_bucket|
        random_Choice = generate_random_array(@words, 3)
        random_Choice.each{|rc| choice_bucket.push(rc.description)}
    end
    
    # all words have to go into the first box. Check the comments in learnSession model for more information
    @learn_session.box0 = @learn_session.word_ids

    #for later, when the usermanagement works
    #@learn_session.user = current_user

    respond_to do |format|
      if @learn_session.save
        format.html { redirect_to learn_session_learn_mode_path(@learn_session.id), notice: 'Learn session was successfully created.' }
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
        format.html { redirect_to @learn_session, notice: 'Learn session was successfully updated.' }
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
      format.html { redirect_to learn_sessions_url, notice: 'Learn session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /learn_sessions/1/learn_mode
  def learn_mode
    puts params
    @learn_session = LearnSession.find(params[:learn_session_id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_learn_session
      @learn_session = LearnSession.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def learn_session_params
      params[:learn_session]
      params.require(:learn_session).permit(:user, :completed, :wors_ids => [], :box0 => [], :box1 => [], :box2 => [], :box3 => [], :box4 => [])
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
