class Car < ActiveRecord::Base
  def to_s
    "#{self.year} #{self.make} #{self.model}, Inventory ##{self.id}"
  end
  acts_as_versioned
end

