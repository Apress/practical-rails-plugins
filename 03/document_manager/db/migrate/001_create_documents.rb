class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.string     :description
      t.timestamps
      t.integer    :size
      t.string     :content_type
      t.string     :filename
      t.integer    :height
      t.integer    :width
      t.integer    :parent_id
      t.string     :thumbnail
    end
  end
  def self.down
    drop_table :documents
  end
end

