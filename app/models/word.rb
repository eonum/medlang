class Word
  include Mongoid::Document

  has_many :categories

  field :name_de, type: String
  field :name_en, type: String
  field :description_de, type: String
  field :description_en, type: String
  field :syntactical_category_de, type: String
  field :syntactical_category_en, type: String
  field :semantical_categories_de, type: String, :default => nil
  field :semantical_categories_en, type: Array


  # OPTIMIZE: if the word allready exist, it should ask the user if he wants to edit the existing word.
  validates :name_de, uniqueness: {message: "Dieses Wort gibt es bereits." }

  validates :name_de, presence: true;
  validates :description_de, presence: true;
  validates :syntactical_category_de, presence: true;
  validates :semantical_categories_de, presence: true;

end
