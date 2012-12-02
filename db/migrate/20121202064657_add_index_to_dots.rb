class AddIndexToDots < ActiveRecord::Migration
  def up
    add_index :dots, :xylotone_id, :name => 'xylotone_id_ix'
  end

  def down
    remove :dots, 'xylotone_id_ix'
  end
end
