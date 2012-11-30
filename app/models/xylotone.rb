class Xylotone < ActiveRecord::Base

  attr_accessible :dot_collection, :original_image

  mount_uploader :original_image, OriginalImageUploader

end