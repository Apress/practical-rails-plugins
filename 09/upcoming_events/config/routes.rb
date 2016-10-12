ActionController::Routing::Routes.draw do |map|
  map.connect 'admin/events/:action/:id', :controller => 'events_admin'
  map.connect 'admin/guests/:action/:id', :controller => 'guests_admin'
  map.root :controller => 'frontpage'
  
  map.comatose_admin 'admin/cms'
  map.comatose_root '', :layout => 'application'
end
