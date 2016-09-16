class NewsAndNotification < ActiveRecord::Base

	def self.update_from_news(feed_url)
		url = "http://www.bimabazaar.com/general-insurance-news?format=feed&type=rss"
		feeds = Feedjira::Feed.fetch_and_parse(feed_url)
		add_entries(feeds)
	end


	def self.update_from_feed_continuously(feed_url, delay_interval = 15.minutes)
	  feed = Feedzirra::Feed.fetch_and_parse(feed_url)
	  add_entries(feed.entries)
	  loop do
	    sleep delay_interval.to_i
	    feed = Feedzirra::Feed.update(feed)
	    add_entries(feed.new_entries) if feed.updated?
	  end 
	end


private
	def add_entries(entries)
		entries.each do |entry|
			unless exists? :guid => entry.id
				create!(
					:name => entry.title,
					:summary => entry.summary,
					:url => entry.url,
					:published_at => entry.published,
					:guid => entry.id)
			end
		end
	end
end