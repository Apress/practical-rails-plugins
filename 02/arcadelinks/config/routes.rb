ActionController::Routing::Routes.draw do |map|
  map.resources :links, :member => { :tag => :post }
  map.resources :tags
end
