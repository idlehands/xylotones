class AddDotFileToXylotones < ActiveRecord::Migration
  def change
    add_column :xylotones, :dot_file, :string
  end
end
