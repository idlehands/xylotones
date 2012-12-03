class Dot < ActiveRecord::Base
  attr_accessible :delete_status, :gray, :xcoord, :ycoord, :xylotone_id

  belongs_to :xylotone

  validates :xcoord, :ycoord, :gray, :delete_status, :xylotone_id, :presence => :true

end

