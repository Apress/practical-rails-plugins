class Author < ActiveRecord::Base
  has_many :articles
  validates_presence_of :name
end

