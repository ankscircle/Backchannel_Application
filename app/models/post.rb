class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  attr_accessible :user_id, :content,:category_id             #without this it was calling it protected
  validates :user_id, :presence => true
  validates :content, :presence => true
  validates :category_id, :presence =>true

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

  def self.modified_post(post_id_for_modification)
    pst = Post.find_by_id(post_id_for_modification)
    pst.updated_at = Time.now
    pst.save
  end

  def self.delete_post_when_id_given(post_id_from_controller)
    @comments_to_delete = Comment.where(:post_id => post_id_from_controller)
    @comments_to_delete.each{|del|
    Comment.delete_comments_when_id_given(del.id)
    }
    Vote.delete_votes_related_to_an_id("1",post_id_from_controller)
    (Post.find_by_id(post_id_from_controller)).destroy
  end

  def self.search_all_post(search_text)
    array_posts = []
    posts_with_the_given_keyword  = "%" + search_text +"%"
    posts_with_search_condition_applied = Post.find(:all, :conditions => ['content LIKE ?',posts_with_the_given_keyword])

    posts_with_search_condition_applied.each{|e|
      array_posts << e.id
    }
    users_with_search_conditions_applied = User.find(:all, :conditions => ['username LIKE ?',posts_with_the_given_keyword])
    users_with_search_conditions_applied.each{|user|
      get_all_postings = Post.find(:all, :conditions => ['user_id LIKE ?',user.id])
      get_all_postings.each{|addthis|
      array_posts << addthis.id
      }
     }
    category_with_search_conditions_applied = Category.find(:all, :conditions => ['name LIKE ?',posts_with_the_given_keyword])
    category_with_search_conditions_applied.each{|cate|
      get_all_postings = Post.find(:all, :conditions => ['category_id LIKE ?',cate.id])
      get_all_postings.each{|addthis|
        array_posts << addthis.id
      }
    }


    posts_with_complete_tuple = Post.find(array_posts)
    Rails.logger.info(posts_with_complete_tuple)
    posts_with_search_condition_applied
  end
end
