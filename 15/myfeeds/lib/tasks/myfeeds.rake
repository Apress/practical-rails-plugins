namespace :feeds do
  desc "Update from aggregator feed sources"
  task :update => [:environment] do |t|
    require 'lib/feed_aggregator.rb'
    FeedAggregator.update
  end
 end 
