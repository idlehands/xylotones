class Dot < ActiveRecord::Base
  attr_accessible :delete_status, :gray, :xcoord, :ycoord, :xylotone_id

  belongs_to :xylotone

  validates :xcoord, :ycoord, :gray, :xylotone_id, :presence => :true

  scope :shown, where(:delete_status => false)

  def hide
    self.update_attributes :delete_status => true
  end

end

