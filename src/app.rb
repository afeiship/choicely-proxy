#!/usr/bin/env ruby

# Instead of loading all of Rails, load the
# particular Rails dependencies we need
require "sqlite3"
require "active_record"
require_relative "models/application_record"
require_relative "models/proxy"

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "db/choicely-proxy.sqlite3",
)
