  class GuestsAdminController < ApplicationController
    before_filter :authenticate_as_admin

    layout 'admin'
    active_scaffold :guest do |config|
     config.list.columns = [:name, :description, :upcoming_events]      
     config.create.columns = config.update.columns = 
                           [:name, :description, :events]      
    end
  end
