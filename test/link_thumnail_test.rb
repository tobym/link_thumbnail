require 'link_thumbnail'
require 'minitest/autorun'
require 'mocha'

class LinkThumbnailTest < MiniTest::Unit::TestCase

  FIXTURES = {
    :opengraph => File.join(File.dirname(__FILE__), "fixtures", "open_graph.html"),
    :opengraph_no_tag => File.join(File.dirname(__FILE__), "fixtures", "open_graph_no_tag.html"),
    :opengraph_bad_tag => File.join(File.dirname(__FILE__), "fixtures", "open_graph_bad_tag.html"),

    :oembed_json => File.join(File.dirname(__FILE__), "fixtures", "oembed_json.html"),
    :oembed_json_photo_response => File.join(File.dirname(__FILE__), "fixtures", "oembed_photo_response.json"),
    :oembed_json_thumbnail_response => File.join(File.dirname(__FILE__), "fixtures", "oembed_thumbnail_response.json"),

    :oembed_xml => File.join(File.dirname(__FILE__), "fixtures", "oembed_xml.html"),
    :oembed_xml_thumbnail_response => File.join(File.dirname(__FILE__), "fixtures", "oembed_thumbnail_response.xml"),
    :oembed_xml_photo_response => File.join(File.dirname(__FILE__), "fixtures", "oembed_photo_response.xml"),

    :microformat => File.join(File.dirname(__FILE__), "fixtures", "microformat.html")
  }

  def test_opengraph
    assert_equal "http://ia.media-imdb.com/images/rock.jpg", LinkThumbnail.thumbnail_url(FIXTURES[:opengraph])
  end

  def test_opengraph_no_tag
    assert_nil LinkThumbnail.thumbnail_url(FIXTURES[:opengraph_no_tag])
  end

  def test_opengraph_bad_tag
    assert_nil LinkThumbnail.thumbnail_url(FIXTURES[:opengraph_bad_tag])
  end

  def test_oembed_thumbnail_json
    LinkThumbnail.expects('fetch').with("http://flickr.com/services/oembed?url=http%3A//flickr.com/photos/bees/2362225867/&format=json").returns(open(FIXTURES[:oembed_json_thumbnail_response]).read)

    assert_equal "http://example.com/thumbnail.jpg",
      LinkThumbnail.thumbnail_url(FIXTURES[:oembed_json])
  end

  def test_oembed_photo_json
    LinkThumbnail.expects('fetch').with("http://flickr.com/services/oembed?url=http%3A//flickr.com/photos/bees/2362225867/&format=json").returns(open(FIXTURES[:oembed_json_photo_response]).read)

    assert_equal "http://farm4.static.flickr.com/3123/2341623661_7c99f48bbf_m.jpg",
      LinkThumbnail.thumbnail_url(FIXTURES[:oembed_json])
  end

  def test_oembed_thumbnail_xml
    LinkThumbnail.expects('fetch').with("http://flickr.com/services/oembed?url=http%3A//flickr.com/photos/bees/2362225867/&format=xml").returns(open(FIXTURES[:oembed_xml_thumbnail_response]).read)
    
    assert_equal "http://example.com/thumbnail.jpg", LinkThumbnail.thumbnail_url(FIXTURES[:oembed_xml])
  end

  def test_oembed_photo_xml
    LinkThumbnail.expects('fetch').with("http://flickr.com/services/oembed?url=http%3A//flickr.com/photos/bees/2362225867/&format=xml").returns(open(FIXTURES[:oembed_xml_photo_response]).read)

    assert_equal "http://farm4.static.flickr.com/3123/2341623661_7c99f48bbf_m.jpg",
      LinkThumbnail.thumbnail_url(FIXTURES[:oembed_xml])
  end

  def test_microformat
    assert_equal "http://example.com/thumb.jpg", LinkThumbnail.thumbnail_url(FIXTURES[:microformat])
  end

end
