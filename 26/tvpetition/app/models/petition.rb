class Petition < ActiveRecord::Base
  has_many :signatures

  validates_presence_of :name, :description
  validates_uniqueness_of :name
end

