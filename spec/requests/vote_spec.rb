require "rspec"
require 'spec_helper'

describe "Voting Comment and Posts" do
  before :all do
    @user1 = User.new(:username => 'deepalirai',:email => 'deepalirai@gmail.com',:password => "ankita123",:role => "1")
    @user1.save!
    @user1 = User.new(:username => 'superman',:email => 'superman@gmail.com',:password => "superman",:role => "1")
    @user1.save!
  end
  it "should vote posts & comment" do
    visit "/"
    expect {
      @category = Category.new(:name => "Testing")
      @category.save!
      click_link 'Log In'
      fill_in "name_or_email", :with =>  "deepalirai"
      fill_in "login_pass", :with => "ankita123"
      click_button "login"
      puts page.should have_content "Welcome"

      fill_in 'create_post_new', :with => "And NC State still moves forward today. With more than 34,000 students and nearly 8,000 faculty and staff, North Carolina State University is a comprehensive university known for its leadership in education and research, and globally recognized for its science, technology, engineering and mathematics leadership."
      select "Testing", :from => 'select_category'
      click_button "create_new_post"

      page.should have_content " and globally recognized for its science"


      click_link "Go to Complete post"
      fill_in "create_new_comment", :with => "This University is in Raleigh and is a part of UNC System"
      click_button "comment_create"

      visit "/"
      click_link "Logout"
      click_link 'Log In'
      fill_in "name_or_email", :with =>  "superman"
      fill_in "login_pass", :with => "superman"
      click_button "login"
      puts page.should have_content "Welcome"

      click_link "Go to Complete post"
      click_link "Vote Post"
      click_link "Vote Comment"


    }.to change(Vote, :count).by(2)

    page.should have_content "and is a part of UNC System"
  end
end