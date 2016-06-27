class ImageSync
  def initialize images_folder
    @images_folder = images_folder
  end

  def _get_by_resolution image_ids, resolution
    image_filenames = []
    image_ids.each do |image|
      p image
      image_filenames.push @images_folder + "#{resolution}/#{image.part_id}_#{image.id}.jpg"
    end
    image_filenames
  end

  def get_part_type_specific_image sku

  end

  def get_default_image sku
    @images_folder + "#{resolution}/turbo.jpg"
  end

  def _find_images  sku, resolution
    img_ids = ProductImage.where part_id: sku
    if img_ids
      _get_by_resolution img_ids, resolution
    else
      get_default_image sku
    end
  end

  def get_image sku, resolution='1000'
    images  =  _find_images sku, resolution
    images[0]
  end
end