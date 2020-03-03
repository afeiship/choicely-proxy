class Proxy < ApplicationRecord
  validates_uniqueness_of :url
end
