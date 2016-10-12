class Link < ActiveRecord::Base
  acts_as_taggable
  has_ajaxful_rates

  validates_presence_of :url, :name
  validates_uniqueness_of :url
end
