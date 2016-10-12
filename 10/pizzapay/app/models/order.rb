class Order < ActiveRecord::Base
  validates_presence_of :customer_name, :customer_email, :customer_phone, 
      :customer_address, :customer_city

  has_many :order_items, :dependent => :destroy
  has_many :pizzas, :through => :order_items

  attr_protected :paid, :authorization

  def price
    self.order_items.inject(0) { |sum, item| sum += item.price }
  end

  def reference_number
    "C#{self.created_at.strftime("%w%S")}#{self.id}"
  end

  def summary
    self.order_items.collect { |item| "#{item.quantity}x #{item.pizza.name}" }
  end

  def complete(gateway_response)
    if gateway_response.success?
      self.paid = true
      self.authorization = gateway_response.authorization
      self.save
    else
      false
    end
  end
end

