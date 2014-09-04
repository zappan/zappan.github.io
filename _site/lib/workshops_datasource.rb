# encoding: utf-8

module Nanoc3::DataSources

  class Workshops < Nanoc3::DataSource
    identifier :workshops

    def items
      @items ||= begin
        require 'json'
        require 'enumerator'
        require 'babosa'
        require 'sanitize'
        require 'redcarpet'
        
        raw_items = JSON.parse(File.read('workshops/workshops.json'))
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

        # Convert to items
        raw_items.each_with_index.map do |raw_item, i|

          image = (raw_item["name"] || "").to_slug.normalize.to_s + '.jpg'
          path = "/" + ['images', 'speakers', image].join('/')

          config = {
            :elements => ['a', 'ul', 'li', 'p']
          }

          # Get data
          attributes = {
            abstract: Sanitize.fragment(raw_item['abstract'], config),
            image: path,
            title: raw_item['title'],
            name: raw_item['name'],
            min: raw_item['min'],
            max: raw_item['max'],
            lang: raw_item['lang'],
            level: raw_item['level'],
            duration: raw_item['duration'],
            prerequisites: Sanitize.fragment(raw_item['prerequisites'], config),
            price: raw_item['price'],
            time: raw_item['time'],
            long_bio: markdown.render(raw_item['long_bio'] || '')
            
          }


          identifier = ([attributes[:name], attributes[:title]].join(' ') || "").to_slug.normalize.to_s
          mtime = nil

          # Build item
          Nanoc3::Item.new(attributes[:abstract], attributes, identifier, mtime)
        end
      end
    end

  end

end
