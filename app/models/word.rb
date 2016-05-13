class Word
  include Mongoid::Document

  has_many :categories

  field :name_de, type: String
  field :name_en, type: String
  field :description_de, type: String
  field :description_en, type: String
  field :syntactical_category_de, type: String
  field :syntactical_category_en, type: String
  field :semantical_categories_de, type: Array, :default => nil
  field :semantical_categories_en, type: Array


  # OPTIMIZE: if the word allready exist, it should ask the user if he wants to edit the existing word.
  validates :name_de, uniqueness: {message: "Dieses Wort gibt es bereits." }

  validates :name_de, presence: true;
  validates :description_de, presence: true;
  validates :syntactical_category_de, presence: true;
  validates :semantical_categories_de, presence: true;



  def self.get_previous_word(current_word)
    # mongodb don't allow index function so first i create a normal array words with the ids, this way i can read the index and then i give the mongo word back with this index -1
    words_mongo = Word.all
    words = []
    Word.each{|w| words.push(w.id)}
    index = words.index(current_word.id)
    index = index - 1
    words_mongo[index]
  end

  def self.get_next_word(current_word)
    words_mongo = Word.all
    words = []
    Word.each{|w| words.push(w.id)}
    index = words.index(current_word.id)
    index = index + 1
    words_mongo[index]
  end

end
