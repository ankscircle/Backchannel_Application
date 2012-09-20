require "rspec"
require 'spec_helper'

describe UsersController do
  before :each do
    @user = User.new(:username => 'radhika',:email => 'radhika@gmail.com',:password => "radhika123",:password_confirmation => "radhika123", :role => "0")
    @user.save!
  end
  it "should create a new user" do
    get :new, :username => @user.id, :email => @user.email,:password => @user.password,:password_confirmation => @user.password_confirmation,:role => @user.role
    User.exists?(@user.id).should be_true
  end
end

