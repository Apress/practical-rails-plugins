class FeedItemsController < ApplicationController
  def index
    @feed_items = FeedItem.paginate(:all, 
      :order => "published_at DESC", 
      :page => params[:page], 
      :per_page => 10)
  end
end
