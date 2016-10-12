class EventsAdminController < ApplicationController
  before_filter :authenticate_as_admin
  layout 'admin'
  active_scaffold :events do |config|
    config.list.columns = [:occurs_at, :title, :guests]
  end
end

