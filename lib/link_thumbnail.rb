require 'nokogiri'
require 'open-uri'

module LinkThumbnail
  class << self
    def thumbnail_url(file)
      doc = Nokogiri.parse(open(file))
      if element = doc.xpath('//meta[@property="og:image" and @content]').first
        return element.attributes['content'].value
      end
    end
  end
end
