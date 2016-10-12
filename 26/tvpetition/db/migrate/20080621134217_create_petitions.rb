class CreatePetitions < ActiveRecord::Migration
  def self.up
    create_table :petitions do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :petitions
  end
end
