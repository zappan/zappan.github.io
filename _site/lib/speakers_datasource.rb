# encoding: utf-8

module Nanoc3::DataSources

  class Speakers < Nanoc3::DataSource
    identifier :speakers

    def items
      @items ||= begin
        require 'json'
        require 'enumerator'
        require 'babosa'

        # Parse as JSON
        
        raw_items = JSON.parse(File.read('speakers/speakers.json'))

        # Convert to items
        raw_items.each_with_index.map do |raw_item, i|
          # Get data
          attributes = {
            short_abstract: raw_item['short_abstract'],
            long_abstract: raw_item['long_abstract'],
            title: raw_item['title'],
            image: raw_item['speaker']['image'],
            name: raw_item['speaker']['name'],
            twitter: raw_item['speaker']['twitter'],
            github: raw_item['speaker']['github'],
            long_bio: raw_item['speaker']['long_bio'],
            short_bio: raw_item['speaker']['short_bio'],
          }
          identifier = [attributes[:name], attributes[:title]].join(' ').to_slug.normalize.to_s
          mtime = nil

          # Build item
          Nanoc3::Item.new(attributes[:long_abstract], attributes, identifier, mtime)
        end
      end
    end

  end

end
