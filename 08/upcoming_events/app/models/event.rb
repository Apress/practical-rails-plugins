class Event < ActiveRecord::Base
  has_and_belongs_to_many :guests
  def self.upcoming_events
    self.find(:all,
              :conditions=>"events.occurs_at > date('now')",
              :order=>'occurs_at ASC')
  end
end

