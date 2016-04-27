class User
  include Mongoid::Document
  field :first_name, type: String
  field :last_name, type: String
  field :user_name, type: String
  field :password, type: String
  field :email, type: String
  field :admin, type: Mongoid::Boolean
end
