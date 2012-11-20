require "rspec"
require 'spec_helper'

describe "Comments" do
  before :all do
    @user2 = User.new(:username => 'superman',:email => 'superman@gmail.com',:password => "batman123",:role => "0")
    @user2.save!
    @user3 = User.new(:username => 'greenlantern',:email => 'greenlantern@gmail.com',:password => "joker1234",:role => "1")
    @user3.save!
    @category = Category.new(:name => "Play")
    @category.save!
    @post1 = Post.new(:content => "Batman will save Gotham from Joker.",:user_id => @user2.id,:category_id =>@category.id)
    @post1.save!
    @new_vote = Vote.new(:pc_vote_id =>@post1.id,:post_flag =>"1", :user_id => @user3.id)
    @new_vote.save!
    @new_comment = Comment.new(:comment=> "And the dark knight rises!! Its a good movie.",:post_id => @post1.id,:user_id => @user2.id)
    @new_comment.save
    @new_comment1 = Comment.new(:comment=> "I still have to watch it :( ",:post_id => @post1.id,:user_id => @user2.id)
    @new_comment1.save
    @new_vote = Vote.new(:pc_vote_id =>@new_comment.id,:post_flag =>"0", :user_id => @user3.id)
    @new_vote.save!
    @new_vote2 = Vote.new(:pc_vote_id =>@new_comment1.id,:post_flag =>"0", :user_id => @user3.id)
    @new_vote2.save!
  end
  it "should delete comments and votes when we will now delete a particular comment" do
    Comment.delete_comments_when_id_given(@new_comment.id)
    Comment.exists?(@new_comment.id).should be_false and Vote.exists?(@new_vote.id).should be_false

  end
  it "should delete comments and votes which are related to a particular user" do
    Comment.del_comments_by_user(@user2.id)
    Comment.exists?(@new_comment1.id).should be_false
  end
  it "should fail to create new comment because of validation of comment" do
    @new_comment2 = Comment.new(:post_id => @post1.id,:user_id => @user2.id)
    @new_comment2.save
    @new_comment2.valid?.should be_false
  end
  it "should fail to create new comment because of validation of post id" do
    @new_comment2 = Comment.new(:comment=> "I still have to watch it :( ", :user_id => @user2.id)
    @new_comment2.save
    @new_comment2.valid?.should be_false
  end
  it "should fail to create new comment because of validation of user id" do
    @new_comment2 = Comment.new(:comment=> "I still have to watch it :( ",:post_id => @post1.id)
    @new_comment2.save
    @new_comment2.valid?.should be_false
  end
end