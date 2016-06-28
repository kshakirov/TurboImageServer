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

  def get_part_type_name sku

  end


  def normalize_partname partname
    n = URI.unescape partname
    n = n.remove(" ")
    n.underscore
  end

  def _get_default_image partname
    pname = normalize_partname partname
    ["public/default/#{pname}.jpg"]
  end

  def _find_images  partname, sku, resolution
    img_ids = ProductImage.where part_id: sku
    if img_ids.size > 0
      _get_by_resolution img_ids, resolution
    else
      _get_default_image partname
    end
  end

  def get_image partname, sku, resolution='1000'
    images = []
    if sku
      images  =  _find_images partname, sku, resolution
    else
       images = _get_default_image partname
    end
    images[0]
  end

  def get_default_image partname
    pname = normalize_partname partname
    @images_folder + "default/#{pname}.jpg"
  end
end