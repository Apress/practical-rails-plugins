class CreateTrails < ActiveRecord::Migration
  def self.up
    create_table :trails do |t|
      t.string  :name
      t.integer :usgs_id
      t.string  :state
      t.string  :county
      t.decimal :latitude, :precision => 15, :scale => 10
      t.decimal :longitude, :precision => 15, :scale => 10
      t.timestamps
    end
  end

  def self.down
    drop_table :trails
  end
end

