ActionController::Routing::Routes.draw do |map|
  map.search '/search', :controller => 'search', :action => 'show'
end
