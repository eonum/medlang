require 'set' # is needed for method rand_n

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

end