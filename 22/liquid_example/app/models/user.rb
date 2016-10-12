class User < ActiveRecord::Base
  has_many :posts
  def to_liquid
    { 'username'=>self.username,
      'url'=>self.url }
  end
  def url
    "http://#{self.username}.localhost.localdomain:3000/"
  end
end

