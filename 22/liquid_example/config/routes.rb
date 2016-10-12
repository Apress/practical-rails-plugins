ActionController::Routing::Routes.draw do |map|
  map.root :controller=> 'profiles'
  map.connect ':action', :controller=>'profiles'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

