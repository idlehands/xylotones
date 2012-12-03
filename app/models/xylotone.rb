class Xylotone < ActiveRecord::Base

  include ChunkyPNG::Color
  include DotGen


  attr_accessible :dot_collection, :original_image

  mount_uploader :original_image, OriginalImageUploader

  validates :original_image, :presence => true

  has_many :dots

  #before_create do |xylo|
  #  logger.info xylo.original_image.inspect
  #end

  after_create :make_dots

  def make_dots
    make_and_save_dots
  end

end