require "rspec"
require 'spec_helper'


describe "Vote" do

  before :all do
    @user2 = User.new(:username => 'radhika',:email => 'radhika@gmail.com',:password => "ankita123",:role => "1")
    @user2.save!
    @user3 = User.new(:username => 'Mr Bunny',:email => 'bunny@gmail.com',:password => "ankita123",:role => "1")
    @user3.save!
    @category = Category.new(:name => "Testing2")
    @category.save!
    @post1 = Post.new(:content => "left up to you Sherlock",:user_id => @user2.id,:category_id =>@category.id)
    @post1.save!
    @new_vote = Vote.new(:pc_vote_id =>@post1.id,:post_flag =>"1", :user_id => @user3.id)
    @new_vote.save!

    @new_comment = Comment.new(:comment=> "Sherlock agreed and took up the responsibility",:post_id => @post1.id,:user_id => @user2.id)
    @new_comment.save

    @new_vote2 = Vote.new(:pc_vote_id =>@new_comment.id,:post_flag =>"0", :user_id => @user3.id)
    @new_vote2.save!

  end
  it "should display the required  pattern when asked to do so for a post" do
    vote_dis = Vote.vote_display_post(@post1.id, @user3.username)
    (vote_dis == "You and 0 other people voted").should be_true
  end
  it "should check if user already voted for a post" do
    vote_dis = Vote.check_if_user_already_voted(@user3.username,@post1.id)
    (vote_dis == 0).should be_true
  end

  it "should display the required  pattern when asked to do so for comments" do
    vote_dis = Vote.vote_display_comment(@new_comment.id, @user3.username)
    (vote_dis == "You and 0 other people voted").should be_true
  end
  it "should check if user already voted for a comment" do
    vote_dis = Vote.check_if_user_already_voted_for_comment(@user3.username,@new_comment.id)
    puts @new_comment.user_id, @user3.username
    (vote_dis == 0).should be_true
  end
  it "should delete votes related to a post" do
    Vote.delete_votes_related_to_an_id("1",@post1.id)
    Vote.exists?(@new_vote.id).should be_false
   end
    it "should delete votes related to a comment" do
      Vote.delete_votes_related_to_an_id("0",@new_comment.id)
      Vote.exists?(@new_vote2.id).should be_false
  end

  it "should check for validation of parent comment/post and not save vote" do
    @new_vote3 = Vote.new(:post_flag =>"0", :user_id => @user3.id)
    @new_vote3.save
    @new_vote3.valid?.should be_false
  end
  it "should check for validation of user id who voted and not save vote" do
    @new_vote3 = Vote.new(:pc_vote_id =>@new_comment.id,:post_flag =>"0")
    @new_vote3.save
    @new_vote3.valid?.should be_false
  end
  it "should check for validation of flag and not save vote" do
    @new_vote3 = Vote.new(:pc_vote_id =>@new_comment.id, :user_id => @user3.id)
    @new_vote3.save
    @new_vote3.valid?.should be_false
  end

end