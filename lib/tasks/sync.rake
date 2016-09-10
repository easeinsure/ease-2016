namespace :sync do
  task feeds: [:environment] do
  url = "http://www.bimabazaar.com/general-insurance-news?format=feed&type=rss"
  feeds = Feedjira::Feed.fetch_and_parse(url)
  feeds.entries.each do |entry|
      NewsAndNotification.create!(
        :name => entry.title,
        :summary => entry.summary,
        :url => entry.url,
        :published_at => entry.published,
        :guid => entry.id)
  end
  end
end