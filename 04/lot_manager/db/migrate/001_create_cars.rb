class CreateCars < ActiveRecord::Migration
  def self.up
    create_table :cars do |t|
      t.string :make
      t.string :model
      t.integer :year
      t.decimal :price
      t.boolean :is_on_lot
      t.boolean :is_sold
      t.boolean :is_paid_in_full
      t.text :notes
      t.timestamps
    end
    Car.create_versioned_table
  end
  def self.down
    drop_table :cars
    Car.drop_versioned_table
  end
end

