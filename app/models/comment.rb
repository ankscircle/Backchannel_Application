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
end
