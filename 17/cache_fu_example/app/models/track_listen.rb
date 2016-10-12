class TrackListen < ActiveRecord::Base
  belongs_to :user
  def self.most_recent_listens
    TrackListen.find(:all, :order=>'created_at DESC', :limit=>10)
  end
end

