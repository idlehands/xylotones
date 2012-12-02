require 'spec_helper'

describe Dot do

  before (:all) do
    @dot = Dot.new
  end

  it "has an x coordinate" do
    @dot.should_not be_valid
    @dot.should have(1).errors_on(:xcoord)
  end

  it "has a y coordinate" do
    @dot.should_not be_valid
    @dot.should have(1).errors_on(:ycoord)
  end

  it "has a gray value" do
    @dot.should_not be_valid
    @dot.should have(1).errors_on(:gray)
  end

  it "has a delete status" do
    @dot.should_not be_valid
    @dot.should have(1).errors_on(:delete_status)
  end

end
