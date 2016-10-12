class Link < ActiveRecord::Base
  acts_as_taggable

  validates_presence_of :url, :name
  validates_uniqueness_of :url
end
