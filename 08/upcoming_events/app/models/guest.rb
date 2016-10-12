class Guest < ActiveRecord::Base
  has_and_belongs_to_many :events
  has_and_belongs_to_many :upcoming_events, :class_name=>'Event',
                          :conditions=>"events.occurs_at > date('now')"
end

