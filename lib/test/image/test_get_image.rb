require_relative 'test_helper'
class TestImage < MiniTest::Unit::TestCase
  def test_all
    syncer = ImageSync.new ENV['METADATA_IMAGES_COLLECTION']
    images = syncer.get_image 43856
    p images
  end
end