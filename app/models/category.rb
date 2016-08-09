class Category
  include Mongoid::Document
  include MultiLanguageText



  field :name_de, type: String
  field :name_en, type: String
  field :description_de, type: String
  field :description_en, type: String
  field :category_type, type: String

  # will delete this later, keep it as a reminder.
  #field :type_de, type: String
  #field :type_en, type: String
end
