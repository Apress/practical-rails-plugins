class OrderItem < ActiveRecord::Base
  validates_presence_of :order_id, :pizza_id, :quantity
  validates_inclusion_of :quantity, :in => 1..100
  belongs_to :order
  belongs_to :pizza

  def price
    quantity * pizza.price
  end
end

