require 'link_thumbnail'
require 'minitest/autorun'

class LinkThumbnailTest < MiniTest::Unit::TestCase

  FIXTURES = {
    :opengraph => File.join(File.dirname(__FILE__), "fixtures", "open_graph.html"),
    :opengraph_no_tag => File.join(File.dirname(__FILE__), "fixtures", "open_graph_no_tag.html"),
    :opengraph_bad_tag => File.join(File.dirname(__FILE__), "fixtures", "open_graph_bad_tag.html")
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

end
