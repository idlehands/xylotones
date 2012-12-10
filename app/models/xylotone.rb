class Xylotone < ActiveRecord::Base

  include ChunkyPNG::Color
  include DotGen


  attr_accessible :original_image, :url, :dot_file

  mount_uploader :original_image, OriginalImageUploader
  mount_uploader :dot_file, DotFileUploader

  #validates :url, :original_image, :presence => true
  #validates_uniqueness_of :url

  has_many :dots
  #before_create do |xylo|
  #  logger.info xylo.original_image.inspect
  #end

  #before_create :
  after_create :make_dots

  def make_dots
    make_and_save_dots
  end

  def shown_dots
    self.dots.shown
  end

end