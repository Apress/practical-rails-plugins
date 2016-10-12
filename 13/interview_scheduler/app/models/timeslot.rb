class Timeslot < ActiveRecord::Base
  belongs_to :interviewer, :class_name=>'User',
             :foreign_key=>'interviewer_id'
  belongs_to :interviewee, :class_name=>'User',
             :foreign_key=>'interviewee_id'
end

