class Word
  include Mongoid::Document
  field :word_name, type: String
  field :description, type: String
  field :syntactical_category, type: String
  field :semantical-categories, type: String
end
