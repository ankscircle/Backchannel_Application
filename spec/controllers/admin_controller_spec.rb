require "rspec"
require 'spec_helper'

describe AdminsController do
  before :each do
    @user = User.new(:username => 'batman',:email => 'batman@gmail.com',:password => "batman123",:role => "0")
    @user.save!
  end
  it "should get the user-id parameter and delete that user" do
    get :index, :user_deleted => @user.id, :destroy_user => "1"
    User.exists?(@user.id).should be_false
  end
  it "should get the user-id parameter and assign the admin rights" do
    get :index, :assign_role_user => @user.id, :assign_role => "1"
    User.find(@user.id).role == "1"
  end
  it "should get the user-id parameter and revoke that admin rights" do
    get :index, :revoke_role_user => @user.id, :revoke_role => "1"
    User.find(@user.id).role =="0"
  end

end

