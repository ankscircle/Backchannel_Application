require "rspec"
require 'spec_helper'

describe "Posting Comment" do
  before :each do
    @user1 = User.new(:username => 'roadrunner',:email => 'roadrunner@gmail.com',:password => "ankita123",:role => "1")
    @user1.save!
  end
  it "should create posts" do
    visit "/"
    expect {
      @category = Category.new(:name => "Testing")
      @category.save!
      click_link 'Log In'
      fill_in "name_or_email", :with =>  "roadrunner"
      fill_in "login_pass", :with => "ankita123"
      click_button "login"
      puts page.should have_content "Welcome"
      puts "select there??"

      fill_in 'create_post_new', :with => "And NC State still moves forward today. With more than 34,000 students and nearly 8,000 faculty and staff, North Carolina State University is a comprehensive university known for its leadership in education and research, and globally recognized for its science, technology, engineering and mathematics leadership."
      select "Testing", :from => 'select_category'
      click_button "create_new_post"

      page.should have_content " and globally recognized for its science"


      click_link "Go to Complete post"
      fill_in "create_new_comment", :with => "This University is in Raleigh and is a part of UNC System"
      click_button "comment_create"
    }.to change(Comment, :count).by(1)

    page.should have_content "and is a part of UNC System"
    end
end