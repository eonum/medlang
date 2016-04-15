class Category
  include Mongoid::Document
  has_many :words


  field :name, type: String
  field :description, type: String
  field :type, type: String
end
