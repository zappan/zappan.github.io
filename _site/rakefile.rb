require 'rss'
require 'open-uri'
require 'date'
require 'nokogiri'
require 'yaml'
require 'time'

ENV["TZ"] = "Europe/Zagreb"

namespace :wczg do

  desc "Compile site"
  task :compile do
    puts `nanoc compile && cp -r output/* ../`
  end
end

