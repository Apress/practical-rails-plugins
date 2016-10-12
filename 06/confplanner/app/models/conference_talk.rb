require 'acts_as_state_machine_overrides'

class ConferenceTalk < ActiveRecord::Base
  validates_presence_of :speaker_name, :speaker_email, :speaker_bio,
                        :name, :abstract

  attr_protected :state # protect from mass assignment
  acts_as_state_machine :initial => :proposed

  state :proposed, :after => Proc.new { |p| ConferenceMailer.deliver_proposed(p) }
  state :accepted, :after => Proc.new { |p| ConferenceMailer.deliver_accepted(p) }
  state :scheduled, :after => Proc.new { |p| ConferenceMailer.deliver_scheduled(p) }
  state :rejected, :after => Proc.new { |p| ConferenceMailer.deliver_rejected(p) }

  event :accept_talk do
    transitions :from => :proposed, :to => :accepted
  end

  event :schedule_talk do
    transitions :from => :accepted, :to => :scheduled, :guard => :scheduled?
  end

  event :reject_talk do
    transitions :from => :proposed, :to => :rejected
    transitions :from => :accepted, :to => :rejected
    transitions :from => :scheduled, :to => :rejected
  end

  def scheduled?
    self.errors.add(:scheduled_at, "must be assigned") if self.scheduled_at.blank?
    self.errors.add(:room, "must be assigned") if self.room.blank?
    !self.scheduled_at.blank? && !self.room.blank?
  end
end

