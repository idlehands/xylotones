class CreateDots < ActiveRecord::Migration
  def change
    create_table :dots do |t|
      t.integer :xcoord
      t.integer :ycoord
      t.integer :gray
      t.boolean :delete_status

      t.timestamps
    end
  end
end
