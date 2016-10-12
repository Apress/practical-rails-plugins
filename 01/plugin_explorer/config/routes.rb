ActionController::Routing::Routes.draw do |map|
  map.connect '/foo', :controller => 'foo'

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
