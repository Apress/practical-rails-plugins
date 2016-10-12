ActionController::Routing::Routes.draw do |map|
  map.resources :users, :has_many => :wishes

  map.open_id_complete '/session', :controller => 'sessions', :action => 'create', :method => :get
  map.resource :session

  map.root :controller => 'users', :action => 'index'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login  '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'

  map.simple_captcha '/simple_captcha/:action', :controller => 'simple_captcha'
end

