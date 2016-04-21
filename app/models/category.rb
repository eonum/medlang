class Category
  include Mongoid::Document
  has_many :words


  field :name_de, type: String
  field :name_en, type: String
  field :description_de, type: String
  field :description_en, type: String
  field :type_de, type: String
  field :type_en, type: String
end
