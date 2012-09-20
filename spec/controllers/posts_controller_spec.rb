require "rspec"
require 'spec_helper'

describe PostsController do
  before :all do
    @user2 = User.new(:username => 'rad',:email => 'rad@gmail.com',:password => "ankita123",:role => "1")
    @user2.save!
    @user3 = User.new(:username => 'Mr Bunny',:email => 'bunny@gmail.com',:password => "ankita123",:role => "1")
    @user3.save!
    @category = Category.new(:name =>"SuperHeroes")
    @category.save
    @post = Post.new(:user_id => @user2.id,:content => "Hi This is Hello Post",:category_id => @category.id)
    @post.save
    @new_comment = Comment.new(:comment=> "Sherlock agreed and took up the responsibility",:post_id => @post.id,:user_id => @user3.id)
    @new_comment.save
    @new_votep = Vote.new(:pc_vote_id =>@post.id,:post_flag =>"1", :user_id => @user2.id)
    @new_votep.save!
    @new_votec = Vote.new(:pc_vote_id =>@new_comment.id,:post_flag =>"0", :user_id => @user2.id)
    @new_votec.save!

  end
  it "should vote post" do
    session[:user_id] = @user2
    get :index, :post_id_from_view => @post.id, :vote_bool => "1"
    Vote.exists?(:pc_vote_id => @post, :post_flag =>"1",:user_id => @user2.id)
  end
  it "should vote comment" do
    session[:user_id] = @user2
    get :index, :comment_id_for_new => @new_comment.id, :post_id_from_view => @post.id, :vote_bool => "2"
    Vote.exists?(:pc_vote_id => @new_comment, :post_flag =>"0",:user_id => @user2.id)
  end

  it "should delete post" do
    get :index, :post_id_from_view => @post.id, :delete_post => "delete_post"
    Post.exists?(@post.id).should be_false
  end
  it "should delete comment" do
    get :index, :post_id_from_view => @post.id, :comment_id_from_view => @new_comment.id, :delete_comment => "delete_comment"
    Comment.exists?(@new_comment.id).should be_false
  end

end

