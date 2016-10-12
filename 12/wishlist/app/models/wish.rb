class Wish < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title, :url, :user_id
end

