class Category
  include Mongoid::Document

  field :name, type: String
  field :description, type: String
  field :category_type, type: String
  field :language, type: String
end
