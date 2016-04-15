class Category
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :type, type: String
end
