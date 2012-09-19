require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  it "should require a name" do
    Category.new(:name => "").should_not be_valid
  end
end
