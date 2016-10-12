ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'billing'
  map.connect ':controller/:action.:format'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

