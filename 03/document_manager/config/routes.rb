ActionController::Routing::Routes.draw do |map|
  map.resources 'documents'
  map.connect   '/documents_for_today.zip',
                :controller=>'documents',
                :action=>'index',
                :today_only=>true,
                :format=>'zip'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

