class InitialSchema < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.datetime :occurs_at
      t.timestamps 
    end
    create_table :guests do |t|
      t.string :name
      t.string :description
      t.string :href
      t.timestamps 
    end
    create_table :events_guests, :id=>false do |t|
      t.integer :event_id
      t.integer :guest_id
    end
    
  end

  def self.down
    drop_table :events_guests
    drop_table :guests
    drop_table :events
  end
end
