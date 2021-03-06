require "rspec"
require 'spec_helper'


describe "Post" do

  before :all do
      @user1 = User.new(:username => 'batgirl',:email => 'batgirl@gmail.com',:password => "ankita123",:role => "1")
      @user1.save!
      @category = Category.new(:name => "Testing")
      @category.save!
      @post = Post.new(:content => "left up to you Sherlock",:user_id => @user1.id,:category_id =>@category.id)
      @post.save!
  end

  it "should modify post by updating its updation time" do

    pst_pre_time = @post.updated_at
    Post.modified_post(@post.id)
    puts pst_pre_time
    puts Post.find(@post.id).updated_at
    (pst_pre_time != Post.find(@post.id).updated_at).should be_true
  end
     it "should search in the post for keyword in content" do

       pst = Post.search_all_post("Sherlock")
       (pst.size > 0).should be_true
     end

  it "should be deleted when id given " do

    Post.delete_post_when_id_given(@post.id)
    Post.exists?(@post.id).should be_false
  end
  it "should fail to create new post because of validation of user id" do
      post2 = Post.new(:content => "left up to you Sherlock",:category_id =>@category.id)
    post2.save
    post2.valid?.should be_false
  end
  it "should fail to create new post because of validation of content" do
      post2 = Post.new(:user_id=>@user1.id,:category_id =>@category.id)
    post2.save
    post2.valid?.should be_false
  end
  it "should fail to create new post because of validation of category" do
    post2 = Post.new(:content=>"Hello World",:user_id=>@user1.id)
    post2.save
    post2.valid?.should be_false
  end
end