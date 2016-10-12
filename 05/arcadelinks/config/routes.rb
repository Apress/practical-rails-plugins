ActionController::Routing::Routes.draw do |map|
  map.resources :links, :member => { :tag => :post, :rate => :post }
  map.resources :tags
end
