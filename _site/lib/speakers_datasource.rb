# encoding: utf-8

module Nanoc3::DataSources

  class Speakers < Nanoc3::DataSource
    identifier :speakers

    def items
      @items ||= begin
        require 'json'
        require 'enumerator'
        require 'babosa'
        require 'redcarpet'

        # Parse as JSON
        # 
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
        
        raw_items = JSON.parse(File.read('speakers/speakers.json'))

        # Convert to items
        raw_items.each_with_index.map do |raw_item, i|

          image = raw_item["speaker"]["name"].to_slug.normalize.to_s + '.jpg'
          path = "/" + ['images', 'speakers', image].join('/')

          # Get data
          attributes = {
            short_abstract: markdown.render(raw_item['short_abstract']),
            long_abstract: markdown.render(raw_item['long_abstract']),
            title: raw_item['title'],
            image: path,
            name: raw_item['speaker']['name'],
            twitter: raw_item['speaker']['twitter'],
            github: raw_item['speaker']['github'],
            long_bio: markdown.render(raw_item['speaker']['long_bio']),
            short_bio: markdown.render(raw_item['speaker']['short_bio']),
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
