require 'spec_helper'

describe "User Signup" do
  before :all do
    @user1 = User.new(:username => 'deepali',:email => 'deepali@gmail.com',:password => "ankita123",:role => "1")
    @user1.save!
  end
  describe "Logging In" do
    it "Logs in the user and redirects to home page" do
      visit "/"
      puts page.should have_content "Search"
      click_link 'Log In'
         puts "CAme to login"
        puts page.should have_content "Username"
        fill_in "name_or_email", :with =>  "deepali"
        fill_in "login_pass", :with => "ankita123"
        click_button "login"
        page.should have_content "Welcome"

    end
  end
  describe "Signing up" do
        it "Adds a new contact and displays the results" do
          visit "/"
          expect{
            click_link 'Sign Up'
            fill_in "user", :with => "John"
            fill_in "email", with: "Smith@email.com"
            fill_in "password", with: "123456"
            fill_in "passwordconf", with: "123456"
            check("role")
            click_button "signup"
          }.to change(User,:count).by(1)
          page.should have_content "successfully"

        end
        end


end