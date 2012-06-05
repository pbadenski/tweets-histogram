require 'date'
require 'open-uri'
require 'json'
require 'progressbar'

def load_tweets(username, pages)
	progressbar = ProgressBar.new("progress", pages)
	(1 .. pages).map { |i|
		progressbar.inc
		JSON.parse(open("https://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=#{username}&count=3200&page=#{i}").lines.reduce)
	}.flatten
end

tweets = load_tweets(ARGV[0], 32)
histogram = tweets.
	map { |t| DateTime.parse(t["created_at"]).hour }.
	reduce({}) { |h, hour| h[hour] = (h[hour] or 0) + 1; h }.
	map { |hour, number| [hour, number.to_f/tweets.count] }.
	sort
histogram.each { |hour, number|
	puts "#{hour} #{number}"
}
