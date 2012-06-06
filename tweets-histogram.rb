require 'date'
require 'open-uri'
require 'json'
require 'progressbar'

def load_tweets(username)
	eval(open("#{ARGV[0]}-tweets-dates.rbon").lines.reduce.strip)
end

tweets = load_tweets(ARGV[0]).map { |t| DateTime.parse(t) }
if ARGV[1] then
	tweets = tweets.select { |t| t.strftime("%A") == ARGV[1] }
end
histogram = tweets.
	map { |t| t.hour }.
	reduce({}) { |h, hour| h[hour] = (h[hour] or 0) + 1; h }.
	map { |hour, number| [hour, number.to_f/tweets.count] }.
	sort
histogram.each { |hour, number|
	puts "#{hour} #{number}"
}
