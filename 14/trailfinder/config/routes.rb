ActionController::Routing::Routes.draw do |map|
  map.trailmaps '/trailmaps', :controller => 'maps', :action => 'show'
end

