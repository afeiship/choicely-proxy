require "sqlite3"
require "active_record"
require "open-uri"
require "nx-xici-proxy"
require "nx-us-proxy"
require "nx-gather-proxy"
require "nx-spys-proxy"
require "nx-real-ip"

include Nx

# init models
require_relative "models/application_record"
require_relative "models/proxy"
require_relative "utilities/choicely_proxy"

# init db
ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "db/choicely-proxy.sqlite3",
)
