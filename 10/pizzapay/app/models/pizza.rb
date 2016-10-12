class Pizza < ActiveRecord::Base
  validates_presence_of :name, :description, :price
  validates_uniqueness_of :name

  has_many :order_items
  has_many :orders, :through => :order_items
end

