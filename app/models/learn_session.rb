require 'set'

class LearnSession

  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  has_one :user
  has_and_belongs_to_many :words, class_name: "Word", inverse_of: nil

  # the idea behind the boxes is the following:
  # first all words go into the first box
  # if a user answers the question for one word correct, the word goes one box up until it's box4
  # a word remains in the current box, when the answer of the user is wrong. It doesn't go one box down!
  # the learnSession is not completed until all words are in box4

  field :box0, type: Array
  field :box1, type: Array
  field :box2, type: Array
  field :box3, type: Array
  field :box4, type: Array
  field :completed, type: Boolean, default: false



  # take the array arr and picks the no_of_values from it and store it in a new array array_off_random_values
  # this method is needed because the sample method of Array doesn't care about duplicates
  def generate_random_array(arr, no_of_values )
    random_numbers = []
    array_of_random_values = []

    random_numbers = rand_n(no_of_values, arr.length)

    i = 0
    while i < max_no_of_values do
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