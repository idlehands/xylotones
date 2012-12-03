require 'spec_helper'

describe Xylotone do

  before(:each) do
    @xylo = Xylotone.new
  end

    it "has an image" do
      @xylo.should_not be_valid
      @xylo.should have(1).errors_on(:original_image)
    end


    xit "has dots" do
      # this was disabled because the dots can't be created until after the initial save
      @xylo.should_not be_valid
      @xylo.should have(1).errors_on(:dots)
    end



end