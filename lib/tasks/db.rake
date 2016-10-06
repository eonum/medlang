require 'csv'
require 'json'


namespace :db do
  task :seed_words, [:directory] => :environment do |args|
    CSV.foreach(File.open(Rails.root + "test/testdata/words.csv", "r"), col_sep: "\t", headers:true) do |row|
      Word.create({
                      name:  row[0],
                      description: row[1],
                      syntactical_category: Category.where(name: row[2]).first,
                      language: row[3],
                      semantical_categories_ids: [""]
                  })
    end
    puts '######### Words import has finished #########'
  end
  task :seed_categories, [:directory] => :environment do |args|
    # quote_char: "|" is needed because of quote sign in the csv check http://stackoverflow.com/questions/9864064/csv-read-illegal-quoting-in-line-x for more details
    CSV.foreach(File.open(Rails.root + "test/testdata/categories.csv", "r"), quote_char: "|", col_sep: ';') do |row|
      Category.create({
                      name:  row[0],
                      description: row[1],
                      category_type: row[2],
                      language: row[3]
                  })
    end
    puts '######### Categories import has finished #########'
  end
end
