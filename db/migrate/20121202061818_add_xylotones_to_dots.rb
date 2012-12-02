class AddXylotonesToDots < ActiveRecord::Migration
  def change
    add_column :dots, :xylotone_id, :integer
  end
end
