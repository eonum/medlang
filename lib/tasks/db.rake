require 'csv'
require 'json'


namespace :db do
  task :seed_words, [:directory] => :environment do |args|
    CSV.foreach(File.open(Rails.root + "test/testdata/json-fixtures/words.csv", 'r'), col_sep: ';') do |row|
      Word.create({
                      name:  row[0],
                      description: row[1],
                      semantical_categories_ids: row[2],
                      syntactical_category: row[3]
                  })
    end
    puts '######### finished #########'
  end
end
