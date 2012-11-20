require "rspec"
require 'spec_helper'


describe "User" do
  #before :all do
  #  @user1 = User.new(:username => 'batman',:email => 'batman@gmail.com',:password => "ankita123",:role => "1")
  #  @user1.save!
  #end

  it "should authenticate correctly" do
    @user1 = User.new(:username => 'doggie',:email => 'doggie@gmail.com',:password => "ankita123",:role => "1")
    @user1.save!
   usr1 = User.authenticate("doggie","ankita123")
    usr1.should_not be_false
  end

  it "should create new user"  do
  @user2 = User.new(:username => 'black',:email => 'black@gmail.com',:password => "ankita123",:role => "1")
  @user2.save!
  (@user2.username).should eq("black")
  end

  it "should check for uniqueness of username"  do
    @user2 = User.new(:username => 'black',:email => 'black@gmail.com',:password => "ankita123",:role => "1")
    @user2.save
    @user3 = User.new(:username => 'black',:email => 'black23@gmail.com',:password => "ankita123",:role => "1")
    @user3.save
    @user3.valid?.should  be_false
  end
  it "should check for uniqueness of email id"  do
    @user2 = User.new(:username => 'black',:email => 'black@gmail.com',:password => "ankita123",:role => "1")
    @user2.save
    @user3 = User.new(:username => 'black23',:email => 'black@gmail.com',:password => "ankita123",:role => "1")
    @user3.save
    @user3.valid?.should  be_false
  end
  it "should fail for password format"  do
    @user2 = User.new(:username => 'black',:email => 'black@gmail.com',:password => "1234",:role => "1")
    @user2.save
    @user2.valid?.should  be_false
  end
  it "should fail for password confirmation not matched with password"  do
    @user2 = User.new(:username => 'black',:email => 'black@gmail.com',:password => "123459",:password_confirmation => "123456",:role => "1")
    @user2.save
    @user2.valid?.should  be_false
  end
  it "should fail for incorrect email format"  do
    @user2 = User.new(:username => 'black',:email => 'black.com',:password => "123456",:role => "1")
    @user2.save
    @user2.valid?.should  be_false
  end
end
