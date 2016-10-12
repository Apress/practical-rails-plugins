class CreateFeedItems < ActiveRecord::Migration
  def self.up
    create_table :feed_items do |t|
      t.string   :feed
      t.string   :title
      t.string   :link
      t.text     :content
      t.datetime :published_at
    end
  end

  def self.down
    drop_table :feed_items
  end
end
