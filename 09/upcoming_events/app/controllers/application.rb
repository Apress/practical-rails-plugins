# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'ca8cbb763cc7896dc7205bf10ad0fc57'

  protected

  def self.active_scaffold_controller_for(klass)
    return "#{klass.to_s.pluralize}AdminController".constantize rescue super
  end
  def authenticate_as_admin()
      
      authenticate_or_request_with_http_basic do |username, password|
          username=='admin' && password='secret'
      end
  end
end
