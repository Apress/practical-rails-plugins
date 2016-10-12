class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  protected
  def self.active_scaffold_controller_for(klass)
    return "#{klass.to_s.pluralize}AdminController".constantize rescue super
  end
  def authenticate_as_admin()
      authenticate_or_request_with_http_basic do |username, password|
          username=='admin' && password=='secret'
      end
  end
end

