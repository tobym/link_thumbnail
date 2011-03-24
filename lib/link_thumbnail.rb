require 'json'
require 'nokogiri'
require 'open-uri'
require 'readability'
require 'readability/document/get_best_candidate'

module LinkThumbnail
  class << self
    def thumbnail_url(url)
      source = open(url).read
      doc = Nokogiri.parse(source)

      if element = doc.xpath('//meta[@property="og:image" and @content]').first
        # OpenGraph
        return element.attributes['content'].value

      elsif element = doc.xpath('//link[@type="application/json+oembed" and @href]').first
        # oEmbed (JSON)
        oembed_json_response = fetch(element.attributes['href'].value)
        json = JSON.parse(oembed_json_response)
        if src = json['thumbnail_url']
          # Thumbnail (generic)
          return src
        elsif json['type'] == 'photo'
          # Photo type
          return json['url']
        end

      elsif element = doc.xpath('//link[@type="text/xml+oembed" and @href]').first
        # oEmbed (JSON)
        oembed_xml_response = fetch(element.attributes['href'].value)
        response = Nokogiri.parse(oembed_xml_response)
        if thumbnail = response.xpath('/oembed/thumbnail_url').first
          # Thumbnail (generic)
          return thumbnail.content
        elsif response.xpath('/oembed[type="photo" and url]').first
          # Photo type
          return response.xpath('/oembed/url').first.content
        end
      elsif element = doc.xpath('//img[@class="photo" and @src]').first
          # Microformat
          return element.attributes['src'].value

      elsif readability_doc = Readability::Document.new(source)
        # Semantic
        if element = readability_doc.get_best_candidate
          if img = element.xpath('//img[@src]').first
            return img.attributes['src'].value
          end
        end
      end
    end

    def fetch(url)
      open(url).read
    end
  end
end
