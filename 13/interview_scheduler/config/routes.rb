ActionController::Routing::Routes.draw do |map|
  map.resources :timeslots, :member=>{:schedule=>:post}
  map.root :controller=>'timeslots', :action=>'index'
  map.resources :users
  map.resource :session
  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

