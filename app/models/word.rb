class Word
  include Mongoid::Document

  has_many :categories

  field :name, type: String
  field :description, type: String
  field :syntactical_category, type: String
  field :semantical_categories, type: Array, :default => nil


  # OPTIMIZE: if the word allready exist, it should ask the user if he wants to edit the existing word.
  validates :name, uniqueness: {message: "Dieses Wort gibt es bereits." }

  validates :name, presence: true;
  validates :description, presence: true;
  validates :syntactical_category, presence: true;
  validates :semantical_categories, presence: true;



  # those two functions are used for navigating from on word to an other.
  # can't use the function index directly on mongo objects so i create the simple array words with all IDs to get the current index, afther that i use this index with a operatoin (+/- 1) to return the complete mongo object
  def self.get_previous_word(current_word)

    mongo_document = Word.all
    words = []
    Word.each{|w| words.push(w.id)}
    index = words.index(current_word.id)
    index = index - 1
    mongo_document[index]
  end

  def self.get_next_word(current_word)
    mongo_document = Word.all
    words = []
    Word.each{|w| words.push(w.id)}
    index = words.index(current_word.id)
    index = index + 1
    mongo_document[index]
  end
end
