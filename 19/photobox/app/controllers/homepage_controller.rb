class HomepageController < ApplicationController
  def index
    @photos =  flickr.photos.search(:user_id => '24631297@N00', :per_page => 20)
  end
end

