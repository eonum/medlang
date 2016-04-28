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

  validates_uniqueness_of :name_de, { message: "Name allready taken" }
end
