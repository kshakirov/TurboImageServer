require_relative 'test_helper'
class TestImage < MiniTest::Unit::TestCase
  def test_watermark
    processor = ImageProcessor.new
    img_blob = processor.run '/var/product_images/resized/1000/6516_2749.jpg'
    File.open('new2.jpg', 'wb'){|f|
      f.write img_blob
    }
  end
end



