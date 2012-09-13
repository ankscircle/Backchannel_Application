class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :content             #without this it was calling it protected
  validates :user_id, :presence => true
  validates :content, :presence => true


  def self.get_all_the_posts
    # get all the posts (sans replies)
    posts = Post.populate_all_posts

    post_array = []
    posts.each do |post|
      post_array << post.id
         end

    p = Post.find(post_array)
    post_to_return = post_array.map{|id| p.detect{|each| each.id == id}}
  end

  # a search method for time-sorted posts (e.g. posts with no parents)
  def self.populate_all_posts
    Post.find(:all,:order => "updated_at DESC")
  end
end
