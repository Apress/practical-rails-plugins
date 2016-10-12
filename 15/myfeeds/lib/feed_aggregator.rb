require 'feed_tools'

class FeedAggregator
  FEED_URLS = ["http://brainspl.at", "http://hackety.org", "http://weblog.jamisbuck.org", "http://rubyinside.com"]

  def self.update
    count = 0
    puts("Updating feeds...")
    FEED_URLS.each do |feed_url|
      FeedTools::Feed.open(feed_url).items.each do |item|
        unless FeedItem.find_by_link(item.link)
          FeedItem.create({
            :title => item.title,
            :feed  => item.feed.url,
            :link  => item.link,
            :content => item.content.gsub(/<[^>]*>|\n/, ''),
            :published_at => item.published
          })
          puts("- #{item.link}")
          count += 1
        end
      end
    end
    puts("Retrieved #{count} feed items")
  end
end
