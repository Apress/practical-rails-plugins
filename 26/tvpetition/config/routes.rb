ActionController::Routing::Routes.draw do |map|
  map.resources :petitions, :has_many => :signatures
end
