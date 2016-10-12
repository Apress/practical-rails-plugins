class CreateTrackListens < ActiveRecord::Migration
  def self.up
    create_table :track_listens do |t|
      t.integer :user_id
      t.string :track_name
      t.timestamps
    end
  end
  def self.down
    drop_table :track_listens
  end
end

