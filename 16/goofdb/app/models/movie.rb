class Movie < ActiveRecord::Base
  has_many :goofs
  validates_presence_of :name
end
