class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string  :file_name
      t.string  :file_ext
      t.string  :name
      t.text    :description
      t.boolean :converted
      t.timestamps
    end
  end

  def self.down
    drop_table :videos
  end
end
