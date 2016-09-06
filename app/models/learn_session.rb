class LearnSession
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated


  has_one :user
  has_many :words

  # the idea behind the boxes is the following:
  # first all words go into the first box
  # if a user answers the question for one word correct, the word goes one box up until it's box4
  # a word remains in the current box, when the answer of the user is wrong. It doesn't go one box down!
  # the learnSession is not completed until all words are in box4
  #
  # An idea would be to put the words directly into the first box without storing them in the attribute words
  # this way you have no duplicates but i don't know if this works with the mongoid relations

  field :box0, type: Array
  field :box1, type: Array
  field :box2, type: Array
  field :box3, type: Array
  field :box4, type: Array
  field :completed, type: Boolean, default: false
end
