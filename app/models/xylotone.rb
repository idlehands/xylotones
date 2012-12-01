class Xylotone < ActiveRecord::Base

  attr_accessible :dot_collection, :original_image

  mount_uploader :original_image, OriginalImageUploader

  def convert_to_chunky
    @chunky_data ||= ChunkyPNG::Canvas.from_file Rails.root.join('public', self.image_url)
  end

  def find_intensity(pixel_block) #returns a number between 0 and 256 that represents the value of the block passed to it
    avg_red   = pixel_block.map{|p| ChunkyPNG::Color.r(p)}.inject(&:+) / pixel_block.size
    avg_green = pixel_block.map{|p| ChunkyPNG::Color.g(p)}.inject(&:+) / pixel_block.size
    avg_blue  = pixel_block.map{|p| ChunkyPNG::Color.r(p)}.inject(&:+) / pixel_block.size
    # puts "#{avg_red} #{avg_green} #{avg_blue}"
    gray = 256 - (0.299 * avg_red + 0.587 * avg_green + 0.114 * avg_blue)
  end

  def create_halftone_data(block_percent)
    halftone_coords = []
    dot_spacing = (@chunky_data.width/100*block_percent).floor
    columns1 = @chunky_data.width/dot_spacing
    columns2 = columns1 - 2
    rows1 = @chunky_data.height/dot_spacing
    rows2 = rows1 - 2

    normal_blocks_positions = (0...columns1).map{|x| x * dot_spacing}.product((0...rows1).map{|y| y * dot_spacing})

    normal_blocks_positions.each do |x,y|
      halftone_coords << [x, y, find_intensity(pixel_block(x,y,dot_spacing))]
    end
    # puts halftone_coords.inspect
    # halftone_coords.each do |coord|
    #   Rails.logger coord.inspect
    # end
    @halftone_coords = halftone_coords
  end

  def pixel_block(x, y, dot_spacing)
    pixels = pixel_coords(x,y, dot_spacing)
    pixels.each do |p|
      # puts p.inspect
    end
    bob = pixels.map {|x,y| @chunky_data.get_pixel(x,y)}
    # bob.each do |p|
    #   puts p.inspect
    # end
    bob
  end

  def pixel_coords(x, y, dot_spacing)
    x_pixel_columns = [@chunky_data.width, x + dot_spacing].min
    y_pixel_rows = [@chunky_data.height, y + dot_spacing].min
    (x...x_pixel_columns).to_a.product((y...y_pixel_rows).to_a)
  end

  def convert_and_save_dots
    convert_to_chunky
    create_halftone_data(2)
    create_dots
  end

  def create_dots
    @halftone_coords.each do |coord|
      self.dots << Dot.create(xpos: coord[0], ypos: coord[1], size: coord[2], halftone_id: self.id) ####### how do I get it the correct info?
    end
  end

  #def export(file_name)
  #  svg_contents = "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\"
  #     width=\"#{@chunky_data.width}px\" height=\"#{@chunky_data.height}px\" viewBox=\"0 0 #{@chunky_data.width} #{@chunky_dataheight}\" enable-background=\"new 0 0 1280 720\" xml:space=\"preserve\">\"\n"
  #
  #  @halftone_coords.each do |coord|
  #    #<circle cx="150" cy="100" r="80" fill="green" />
  #    svg_contents << "<circle cx=\"#{coord[0]}\" cy=\"#{coord[1]}\" r=\"#{(coord[2]/60)}\" fill=\"black\" /> \n"
  #  end
  #
  #  svg_contents << "</svg>"
  #
  #  file = File.open(file_name, 'w')
  #  file.write(svg_contents)
  #  file.close
  #end

end