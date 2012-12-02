class RemoveDotCollectionFromXylotones < ActiveRecord::Migration
  def up
    remove_column :xylotones, :dot_collection
  end

  def down
    add_column :xylotones, :dot_collection, :text
  end
end
