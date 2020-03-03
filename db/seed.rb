# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "sqlite3"
require "active_record"
require_relative "../src/initialize"

# Proxy.create(ip: "127.0.0.1", port: "9090")

Proxy.all.each do |item|
  p item
end
