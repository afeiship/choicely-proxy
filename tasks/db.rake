namespace :db do
  desc "Seed for project."
  task :seed do
    ruby "db/seed.rb"
  end

  desc "Setup database."
  task :setup do
    ruby "db/schema.rb"
  end
end
