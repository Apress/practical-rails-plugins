ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'homepage'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
