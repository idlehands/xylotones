class ConvertDotsToJson < ActiveRecord::Migration
  include DotGen
  
  def up
    xylotones = Xylotone.all
    xylotones.each do |xylo|
      if !xylo.dots.count && xylo.dotfile
        dots = xylo.dots
        write_dots(xylo, dots)
      end
    end
  end

  def down
  end
end
