require "rspec"
require 'spec_helper'


describe "User" do
  before :all do
    @user1 = User.new(:username => 'ankita',:email => 'ankscircle@gmail.com',:password => "ankita123",:role => "1")
    @user1.save!
  end

  it "should authenticate correctly" do
   usr1 = User.authenticate("ankita","ankita123")
    usr1.should_not be_false
   end

 end