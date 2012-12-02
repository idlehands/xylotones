require 'spec_helper'

describe Xylotone do

  before(:each) do
    @xylo = Xylotone.new
  end

    it "has an image" do
      @xylo.should_not be_valid
      @xylo.should have(1).errors_on(:original_image)
    end

    it "has dots" do
      @xylo.should_not be_valid
      @xylo.should have(1).errors_on(:dots)
    end



end