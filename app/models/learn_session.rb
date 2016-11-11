require 'set' # is needed for method rand_n

class LearnSession

  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  has_one :user
  has_and_belongs_to_many :words, class_name: "Word", inverse_of: nil
  has_and_belongs_to_many :box0,class_name: "Word", inverse_of: nil
  has_and_belongs_to_many :box1,class_name: "Word", inverse_of: nil
  has_and_belongs_to_many :box2,class_name: "Word", inverse_of: nil
  has_and_belongs_to_many :box3,class_name: "Word", inverse_of: nil
  has_and_belongs_to_many :box4,class_name: "Word", inverse_of: nil

  # this array contains four choices (to answer a question) for each word from words. One of them is the correct the other 3
  # are wrong

  # the idea behind the boxes is the following:
  # first all words go into the first box
  # if a user answers the question for one word correct, the word goes one box up until it's box4
  # a word remains in the current box, when the answer of the user is wrong. It doesn't go one box down!
  # the learnSession is not completed until all words are in box4

  field :completed, type: Boolean, default: false

end