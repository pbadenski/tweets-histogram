require 'date'
require 'open-uri'
require 'json'
require 'progressbar'

MAX_PAGES=10

def load_tweets(username)
	user = JSON.parse(open("https://api.twitter.com/1/users/show.json?screen_name=#{username}&include_entities=true").lines.reduce)
	pages = [MAX_PAGES, (user["statuses_count"].to_f/200).ceil].min
	progressbar = ProgressBar.new("progress", pages)
	(1 .. pages).map { |i|
		progressbar.inc
		JSON.parse(open("https://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=#{username}&count=200&page=#{i}").lines.reduce)
	}.flatten
end

tweets = load_tweets(ARGV[0])
p tweets.map { |t| t["created_at"] }
