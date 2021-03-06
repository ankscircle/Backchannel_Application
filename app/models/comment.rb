class Comment < ActiveRecord::Base
  belongs_to :post
  attr_accessible :post_id, :comment, :user_id             #without this it was calling it protected
  validates :comment, :presence => true
  validates :post_id, :presence => true
  validates :user_id, :presence => true


  def self.get_comment_by_id(post_id_from_view)
    # c = Comment.find(comments.post_id)
    c= Comment.where(:post_id =>post_id_from_view)
    c.each{|p1| puts p1.id,p1.post_id}
    c
    #comment_to_return = comment_array.map{|id| c1.detect{|each| each.post_id == post_id_from_view}}
  end

  def self.delete_comments_when_id_given(comment_id_for_delete)
    Vote.delete_votes_related_to_an_id("0",comment_id_for_delete)
    (Comment.find_by_id(comment_id_for_delete)).destroy
  end

  def self.del_comments_by_user(id_user_for_comments)
    comments_of_user = Comment.where(:user_id => id_user_for_comments)
    comments_of_user.each{|usr_comm|
    usr_comm.destroy
    }
  end
end
