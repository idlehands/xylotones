class CreateXylotones < ActiveRecord::Migration
  def change
    create_table :xylotones do |t|
      t.string :original_image
      t.text :dot_collection

      t.timestamps
    end
  end
end
