class CreateOrdersPizzas < ActiveRecord::Migration
  def self.up
    create_table :pizzas do |t|
      t.string  :name
      t.text    :description
      t.integer :price, :default => 0
      t.timestamps
    end

    create_table :orders do |t|
      t.string  :customer_name
      t.string  :customer_email
      t.string  :customer_phone
      t.string  :customer_address
      t.string  :customer_city
      t.string  :authorization
      t.boolean :paid, :default => :false
      t.timestamps
    end

    create_table :order_items do |t|
      t.integer :order_id
      t.integer :pizza_id
      t.integer :quantity, :default => 0
    end

    Pizza.create(:name => "The Ruby", :description => "Spicy BBQ Chicken", :price => 1400)
    Pizza.create(:name => "The Haskell", :description => "Pepperoni & Mushroom", :price => 1400)
    Pizza.create(:name => "The Lua", :description => "White Pizza", :price => 1300)
    Pizza.create(:name => "The Perl", :description => "Olives, Peppers, Anchovies", :price => 1500)
    Pizza.create(:name => "The Java", :description => "Lots of Meat!", :price => 1500)
  end

  def self.down
    drop_table :order_items
    drop_table :orders
    drop_table :pizzas
  end
end

