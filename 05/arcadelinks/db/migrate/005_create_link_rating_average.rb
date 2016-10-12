class CreateLinkRatingAverage < ActiveRecord::Migration
  def self.up
    add_column :links, :rating_average, :decimal,
      :precision => 3, :scale => 1, :default => nil
    Link.find(:all).each { |link| link.update_cached_average }
  end

  def self.down
    remove_column :links, :rating_average
  end
end
