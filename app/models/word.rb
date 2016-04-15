class Word
  include Mongoid::Document

  #has_many :categories

  field :word_name, type: String
  field :description, type: String
  field :syntactical_category, type: String
  field :semantical_categories, type: String
end
