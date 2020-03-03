class Proxy < ApplicationRecord
  validates_uniqueness_of :url
  before_save :generate_url

  def generate_url
    self.url = "http://#{self.ip}:#{self.port}"
  end
end
