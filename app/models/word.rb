class Word
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include MultiLanguageText


  belongs_to :syntactical_category, class_name: 'Category', inverse_of: nil, autosave: true
  has_and_belongs_to_many :semantical_categories, class_name: 'Category', inverse_of: nil, autosave: true
  field :name_de, type: String
  field :name_en, type: String
  field :description_de, type: String
  field :description_en, type: String

  # OPTIMIZE: if the word allready exist, it should ask the user if he wants to edit the existing word.
  validates :name_de, uniqueness: {message: "t('word_warning_already_exists')"},:allow_blank => true
  validates :name_en, uniqueness: {message: "t('word_warning_already_exists')"},:allow_blank => true
end
