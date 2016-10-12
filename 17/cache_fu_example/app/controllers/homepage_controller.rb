class HomepageController < ApplicationController
  def index
    @most_recent_listens = TrackListen.most_recent_listens
    render :text=>''
  end
end

