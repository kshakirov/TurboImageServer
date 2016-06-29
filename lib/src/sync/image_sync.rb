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


  def _get_images_list image_ids, resolution
    image_filenames = []
    image_ids.each do |image|
      img = {'sku' => image.part_id, 'id' => image.id, 'resolution' => resolution}
      image_filenames.push img
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
    if partname
      pname = normalize_partname partname
      @images_folder + "default/#{pname}.jpg"
    else
      @images_folder + "default/turbo.jpg"
    end
  end


  def find_images_list sku, resolution
    img_ids = ProductImage.where(part_id: sku).order(id: :asc)
    if img_ids.size > 1
      _get_images_list img_ids[1..-1], resolution
    else
      nil
    end
  end


  def get_images_list sku, resolution
      list = find_images_list sku, resolution
      list.to_json
  end


  def get_image_file sku,  resolution, id
    path = @images_folder + "#{resolution}/#{sku}_#{id}.jpg"
    path
  end
end