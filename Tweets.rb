#!/usr/bin/env ruby

require 'rubygems'
require 'rest-client'
require 'json'
require 'optparse'

opt_parser = OptionParser.new do |opt|
  opt.banner = "Usage: opt_parser COMMAND [OPTIONS]"
  opt.separator  ""
  opt.separator  "Commands"
  opt.separator  "     Tweets: tweets #hashtag (if you try with this command then you will get the latest tweets TEXT based on your hash_tag)"
  opt.separator  "     Trends: trends (if you try with this command then you will get the name and url of trends)"
  opt.separator  "     Twitteri_API: api (if you try with this command then you will get the twitter api)"
  opt.separator  "     Screen_name: screen_name username (if you try with this command then you will get User information in XML format)"
  opt.separator  ""
  opt.separator  "Options"


  opt.on("-h","--help","help") do
    puts opt_parser
  end
end

opt_parser.parse!

def get_params(url)
  response = RestClient.get(url)
  params = response.body
  return params
end

def getJSON()
  return get_params(url)
end


case ARGV[0]
when "tweets"
     @url = "http://search.twitter.com/search.json?q=#{ARGV[1]}&result_type=mixed&rpp=100"
     tweet = JSON.parse(get_params(@url))
     puts "---------------------------- TWEETS TEXT --------------------------"
     tweet['results'].each do |tweet|
          puts tweet['text']+"\n\n"
     end
     puts "----------------------------- END OF TWEETS -----------------------"
when "trends"
     @url = "http://api.twitter.com/1/trends.json"
     trends = JSON.parse(get_params(@url))
     puts "-------------------------- TWITTER TRENDS --------------------------"
     trends['trends'].each do |trend|
          puts "Trend: "+trend['name']+"\t, URL: "+trend['url']+"\n"
     end 
     puts "-------------------------- END TRENDS ------------------------------"
when "screen_name"
     @url="http://twitter.com/statuses/user_timeline.xml?screen_name=#{ARGV[1]}&count=100&callback=?"
     puts get_params(@url)
when "api"
     @url = "http://search.twitter.com/search.json?q=Twitter%20API&result_type=mixed&count=5"
     puts get_params(@url)
else
  puts "please run the following command:- $ruby Tweets.rb --help"
end

