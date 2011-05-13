require 'spec_helper'

describe GitStats do
  it "should have a version" do
    GitStats::VERSION.should be_a(String)
  end
end
