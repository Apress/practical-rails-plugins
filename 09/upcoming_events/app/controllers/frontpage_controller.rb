class FrontpageController < ApplicationController
  def index
    @events  = Event.find_all_upcoming_events
  end
end
