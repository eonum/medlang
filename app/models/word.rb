class Word
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic


  belongs_to :syntactical_category, class_name: 'Category', inverse_of: nil, autosave: true
  has_and_belongs_to_many :semantical_categories, class_name: 'Category', inverse_of: nil, autosave: true
  field :name, type: String
  field :description, type: String
  field :language, type: String

  # OPTIMIZE: if the word allready exist, it should ask the user if he wants to edit the existing word.
  validates :name, uniqueness: {message: "t('word_warning_already_exists')"},:allow_blank => true

  def self.to_csv(options = {:col_sep => ";"})
    CSV.generate(options) do |csv|
      all.each do |word|
        values = word.attributes.values
        csv.add_row values
      end
    end
  end
end
