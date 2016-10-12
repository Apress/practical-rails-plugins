ActionController::Routing::Routes.draw do |map|
  map.connect 'admin/events/:action/:id', :controller=>'events_admin'
  map.connect 'admin/guests/:action/:id', :controller=>'guests_admin'
  map.root :controller=>'frontpage'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

