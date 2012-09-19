require 'spec_helper'

describe "Post Create" do
  before :each do
    @user1 = User.new(:username => 'ankitapawar',:email => 'ankitapawar@gmail.com',:password => "ankita123",:role => "1")
    @user1.save!
  end

  describe "should Log In" do
    it "Logs in the user and redirects to home page" do
      visit "/"
      click_link 'Log In'
      fill_in "name_or_email", :with =>  "ankitapawar"
      fill_in "login_pass", :with => "ankita123"
      click_button "login"
      page.should have_content "Welcome"

    end
  end
  describe "should create a new post on post create button click" do

     it "should create posts" do
       visit "/"
       expect {
         @category = Category.new(:name => "Testing")
         @category.save!
         click_link 'Log In'
         fill_in "name_or_email", :with =>  "ankitapawar"
         fill_in "login_pass", :with => "ankita123"
         click_button "login"
         puts page.should have_content "Welcome"
           puts "select there??"

         fill_in 'create_post_new', :with => "And NC State still moves forward today. With more than 34,000 students and nearly 8,000 faculty and staff, North Carolina State University is a comprehensive university known for its leadership in education and research, and globally recognized for its science, technology, engineering and mathematics leadership."
         select "Testing", :from => 'select_category'
         click_button "create_new_post"
    }.to change(Post, :count).by(1)

    page.should have_content " and globally recognized for its science"
  end
  end
end