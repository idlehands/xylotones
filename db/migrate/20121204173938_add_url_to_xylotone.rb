class AddUrlToXylotone < ActiveRecord::Migration
  def up
    add_column :xylotones, :url, :string
  end

  def down
    remove_column :xylotones, :url
  end
end
