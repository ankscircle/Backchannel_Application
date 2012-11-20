require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  def test_new_user_creation  #We will check if a new user can be added successfully or not
    @user1 = User.new(:username => 'ankita89',:email => 'ankscircle89@gmail.com',:password => "ankita123",:role => "1")
    @user1.save!
    assert_equal "ankita123", u.password
  end

  def test_user_for_uniqueness_of_name     #We will check if a new user when added should have unique name
    u = User.new(:email => "public@gmail.com", :username => "student1", :password => "userapppass",:role=> "0")
    assert !u.save
    assert_equal I18n.translate('activerecord.errors.messages')[:taken], u.errors.on(:name)
  end

  def test_user_to_find_by_login        #When requested correct authorname should be returned
    u = User.new(:email => "userapp@gmail.com", :username => "userapp", :password => "userapppass",:role=> "0")
    u.save!
    assert_equal u, User.find_by_login("userapp@gmail.com")
  end
end
