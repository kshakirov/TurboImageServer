class ImageProcessor

  def get_mark_starting_point img
    return img.width/10 , img.height/2
  end

  def get_text_size img
    img.height/12
  end

  def _run image_name
    img = MiniMagick::Image.open(image_name)
    x_y = get_mark_starting_point img
    font_size = get_text_size img
    img.combine_options do |c|
      c.gravity 'Southwest'
      c.draw "text #{x_y[0]},#{x_y[1]} 'TURBOINTERNATIONAL ©'"
      c.pointsize font_size
      c.encoding 'Unicode'
      c.fill("#2C3539")
    end
    img.to_blob
  end

  def run image_name
    _run image_name
  end
end