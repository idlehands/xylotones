module DotGen #switch from csv to json!

  def convert_to_chunky(image_file)
    @chunky_data ||= ChunkyPNG::Image.from_file(image_file)
  end

  def find_intensity(x,y) #returns a number between 0 and 256 that represents the value of the block passed to it
    pixel = @chunky_data.get_pixel(x,y)
    gray = 256 - (0.299 * ChunkyPNG::Color.r(pixel) + 0.587 * ChunkyPNG::Color.g(pixel) + 0.114 * ChunkyPNG::Color.b(pixel))
  end

  def create_halftone_data(dot_spacing)
    halftone_coords = []
    columns1, rows1 = @chunky_data.width/dot_spacing, @chunky_data.height/dot_spacing
    pixel_positions = (0...columns1).to_a.product((0...rows1).to_a)
    
    dot_index = 0
    pixel_positions.each do |x,y|
      halftone_coords << [dot_index, x, y, (find_intensity(x, y) * 100).to_i, "false"]
      dot_index += 1
    end
    halftone_coords
  end

  def make_and_save_dots(object, image_file)
    convert_to_chunky(image_file)
    dot_coordinates = create_halftone_data(1)
    write_dots(object, dot_coordinates)
  end

  def write_dots(object, dot_data)
    file_name = File.join(Rails.public_path,"temp#{rand(1000000)}.json")
    dot_file = File.open(file_name, 'w') do |f|
      f.write(dot_data.to_json)
    end
    object.dot_file = File.open(file_name)
    object.save
    File.delete(file_name)
    object
  end
  
  def dots_from_url(url)
    JSON.parse(open(url,:ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)
  end

  def delete_dots(deleted_dot_ids, xylotone_id)
    xylotone = Xylotone.find(xylotone_id)
    dots = dots_from_url(xylotone.dot_file.url)
    deleted_dot_ids.each do |id|
      dots[id][4] = "true"
    end
    write_dots(xylotone, dots)
  end


end
