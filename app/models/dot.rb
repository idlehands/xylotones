class Dot < ActiveRecord::Base
  attr_accessible :delete_status, :gray, :xcoord, :ycoord, :xylotone_id

  belongs_to :xylotone

  validates :xcoord, :ycoord, :gray, :delete_status, :xylotone_id, :presence => :true

  HIDDEN = 0
  SHOWN = 1

  scope :shown, where(:delete_status => SHOWN)


  def hide
    self.update_attributes :delete_status => HIDDEN
  end

end

