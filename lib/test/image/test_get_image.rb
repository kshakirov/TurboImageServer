require_relative 'test_helper'
class TestImage < MiniTest::Unit::TestCase
  def test_all
    syncer = ImageSync.new ENV['METADATA_IMAGES_COLLECTION']
    images = syncer.get_image 'turbo',nil, 1000
    assert_equal "/var/product_images/resized/default/turbo.jpg",   images

    images2 = syncer.get_image 'turbo',43856, 1000
    p images2
    assert_equal "/var/product_images/resized/1000/43856_1473.jpg",   images2, "not equal"



    images2 = syncer.get_image 'turbo',10010, 1000
    p images2
    assert_equal "/var/product_images/resized/default/turbo.jpg",   images2, "not equal"

  end
end