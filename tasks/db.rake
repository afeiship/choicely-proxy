require_relative "../src/initialize"

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

  desc "Test db proxies."
  task :upup do
    Proxy.all.each do |proxy|
      real_ip = open(
        "http://icanhazip.com/",
        read_timeout: 10,
        open_timeout: 10,
        proxy: proxy[:url],
      ).read

      puts real_ip
    end
  end
end
