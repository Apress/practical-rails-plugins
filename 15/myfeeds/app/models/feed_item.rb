class FeedItem < ActiveRecord::Base
  validates_presence_of :feed, :title, :link, :published_at
  validates_uniqueness_of :link
end
