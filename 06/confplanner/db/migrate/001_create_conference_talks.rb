class CreateConferenceTalks < ActiveRecord::Migration
  def self.up
    create_table :conference_talks do |t|
      t.string   :speaker_name
      t.string   :speaker_email
      t.text     :speaker_bio
      t.string   :name
      t.text     :abstract
      t.text     :notes
      t.string   :room
      t.datetime :scheduled_at
      t.string   :state
      t.timestamps
    end
  end

  def self.down
    drop_table :conference_talks
  end
end

