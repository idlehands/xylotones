require 'csv'

module DotGen

  def convert_to_chunky
    @chunky_data ||= ChunkyPNG::Image.from_file(self.original_image.path)
  end

  def find_intensity(x,y) #returns a number between 0 and 256 that represents the value of the block passed to it
    pixel = @chunky_data.get_pixel(x,y)
    gray = 256 - (0.299 * ChunkyPNG::Color.r(pixel) + 0.587 * ChunkyPNG::Color.g(pixel) + 0.114 * ChunkyPNG::Color.b(pixel))
  end

  def create_halftone_data(block_percent)
    halftone_coords = []
    dot_spacing = 1
    columns1 = @chunky_data.width/dot_spacing
    rows1 = @chunky_data.height/dot_spacing
    pixel_positions = (0...columns1).to_a.product((0...rows1).to_a)

    dot_index = 0
    pixel_positions.each do |x,y|
      halftone_coords << [dot_index, x, y, (find_intensity(x, y) * 100).to_i]
      dot_index += 1
    end
    @halftone_coords = halftone_coords
  end

  def make_and_save_dots
    convert_to_chunky
    create_halftone_data(2)
    create_dots
  end

  def create_dots
    #position_shift = (@halftone_coords[1][1] - @halftone_coords[0][1])/2
    CSV.open(File.join(Rails.public_path,"bob.csv"), 'w') do |csv|
      @halftone_coords.each do |dot|
        csv << dot
      end
    end


    #@halftone_coords.each do |coord|
      #if (coord[2]/20).floor != 0
      #  Dot.create(xcoord: (coord[0] + position_shift), ycoord: (coord[1] + position_shift), gray: (coord[2]*100), xylotone_id: self.id, delete_status: false)
      #end
    #end
  end

end