# server.rb
require "sinatra"
require "sinatra/namespace"
require_relative "./initialize"

set :allow_origin, "http://localhost.com:4567"
set :allow_methods, "GET,HEAD,POST"
set :allow_headers, "content-type,if-modified-since"

namespace "/api/v1" do
  before do
    content_type "application/json"
  end

  get "/proxies" do
    Proxy.all.to_json(except: [:id, :created_at, :updated_at])
  end
end
