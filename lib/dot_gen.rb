require 'csv'

module DotGen #switch from csv to json!

  def convert_to_chunky
    @chunky_data ||= ChunkyPNG::Image.from_file(self.original_image.path)
  end

  def find_intensity(x,y) #returns a number between 0 and 256 that represents the value of the block passed to it
    pixel = @chunky_data.get_pixel(x,y)
    gray = 256 - (0.299 * ChunkyPNG::Color.r(pixel) + 0.587 * ChunkyPNG::Color.g(pixel) + 0.114 * ChunkyPNG::Color.b(pixel))
  end

  def create_halftone_data(block_size)
    halftone_coords = []
    dot_spacing = block_size #(@chunky_data.width/100*block_percent).floor
    columns1 = @chunky_data.width/dot_spacing
    rows1 = @chunky_data.height/dot_spacing
    pixel_positions = (0...columns1).to_a.product((0...rows1).to_a)

    dot_index = 0
    pixel_positions.each do |x,y|
      halftone_coords << [dot_index, x, y, (find_intensity(x, y) * 100).to_i, "false"]
      dot_index += 1
    end
    @halftone_coords = halftone_coords
  end

  def make_and_save_dots
    convert_to_chunky
    create_halftone_data(1)
    create_dots
  end

  def create_dots
    file_name = File.join(Rails.public_path,"temp#{rand(1000000)}.csv")
    CSV.open(file_name, 'w') do |csv|
      @halftone_coords.each do |dot|
        csv << dot
      end
    end
    self.dot_file = File.open(file_name)
    self.save
    File.delete(file_name)
    self
  end

  def delete_dots(deleted_dot_ids, xylotone_id)
    xylotone = Xylotone.find(xylotone_id)
    dots = []
    data = open(xylotone.dot_file.url,:ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE)
    CSV.foreach(data, 'r') do |row|
      dot = []
      (0..3).each do |index|
        dot << row[index].to_i
      end
      dot << row[4]
      dots << dot
    end
    deleted_dot_ids.each do |id|
      dots[id][4] = "true"
    end
    #Dry this up!!!! It's a repeat of create_dots, but create_dots is a class method right now
    file_name = File.join(Rails.public_path,"temp#{rand(1000000)}.csv")
    CSV.open(file_name, 'w') do |csv|
      dots.each do |dot|
        csv << dot
      end
    end
    xylotone.dot_file = File.open(file_name)
    xylotone.save
    File.delete(file_name)
  end


end
