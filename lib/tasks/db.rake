namespace :db do

  task all: :environment do
    Rake::Task['db:mongoid:remove_indexes'].execute
    Rake::Task['db:mongoid:create_indexes'].execute
  end

end
