class Xylotone < ActiveRecord::Base

  include ChunkyPNG::Color
  include DotGen


  attr_accessible :original_image, :url, :dot_file

  mount_uploader :original_image, OriginalImageUploader
  mount_uploader :dot_file, DotFileUploader

  validates :original_image, :presence => true
  #validates_uniqueness_of :url

  has_many :dots

  after_create :make_dots

  def make_dots
    make_and_save_dots(self, self.original_image.path)
  end

  def shown_dots
    self.dots.shown
  end

end