class ConvertDotsToJson < ActiveRecord::Migration
  include DotGen
  
  def up
    xylotones = Xylotone.all.each do |xylo|
      if xylo.dots
        index = 0
        new_dots = []
        xylo.dots.each do |dot| 
          new_dots << [index, dot["xcoord"]/8, dot["ycoord"]/8, dot["gray"], dot["delete_status"]]
        index += 1
        end
        write_dots(xylo, new_dots)
      end
    end
  end

  def down
  end
end
