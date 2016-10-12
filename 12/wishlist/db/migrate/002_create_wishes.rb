class CreateWishes < ActiveRecord::Migration
  def self.up
    create_table :wishes do |t|
      t.integer :user_id
      t.string :title
      t.string :url
      t.string :notes
      t.timestamps
    end
  end

  def self.down
    drop_table :wishes
  end
end

