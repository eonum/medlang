class Category
  include Mongoid::Document

  has_many :syntactical_words, class_name: "Word", inverse_of: :syntactical_category, :autosave => true
  has_and_belongs_to_many :semantical_words, class_name: "Word", inverse_of: :semantical_categories, :autosave => true


  field :name_de, type: String
  field :name_en, type: String
  field :description_de, type: String
  field :description_en, type: String
  field :type_de, type: String
  field :type_en, type: String
end
