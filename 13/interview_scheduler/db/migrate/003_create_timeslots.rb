class CreateTimeslots < ActiveRecord::Migration
  def self.up
    create_table :timeslots do |t|
      t.datetime :interview_at
      t.string :position
      t.string :time
      t.integer :interviewer_id
      t.integer :interviewee_id
      t.timestamps
    end
  end
  def self.down
    drop_table :timeslots
  end
end

