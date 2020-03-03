namespace :db do
  desc "Seed for project."
  task :seed do
    ruby "db/seed.rb"
  end

  desc "Setup database."
  task :setup do
    system "cp db/choicely-proxy.sqlite3_bak db/choicely-proxy.sqlite3"
    ruby "db/schema.rb"
  end
end
