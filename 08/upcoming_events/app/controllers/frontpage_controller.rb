class FrontpageController < ApplicationController
  def index
    @events = Event.upcoming_events
  end
end

