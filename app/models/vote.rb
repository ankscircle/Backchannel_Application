class Vote < ActiveRecord::Base
  attr_accessible :user_id, :pc_vote_id, :post_flag           #without this it was calling it protected
  validates :user_id, :presence => true
  validates :pc_vote_id, :presence => true
  validates :post_flag, :presence => true


  def self.vote_display_post(post_id_for_votes,user_name)
    @voted_post  = 1
    @return_string = ""
    @vote_list =  Vote.where(:post_flag => "1",:pc_vote_id => post_id_for_votes)
    @vote_list.each{|vote_part| @voted_post = 0 if User.find(vote_part.user_id).username == user_name }

    if @voted_post == 0
      @return_string = "You and " + (@vote_list.length-1).to_s + " other people voted"
    else
      @return_string = " " << (@vote_list.length).to_s << " other people voted"
    end
    if @vote_list.length ==0
      @return_string = "0 people voted"

    end
    @return_string
    end

  def self.vote_display_comment(comment_id_for_votes, user_name_for_votes)
    @voted_comment  = 1
    @vote_list =  Vote.where(:post_flag => "0",:pc_vote_id =>comment_id_for_votes)
    @vote_list.each{|vote_part| @voted_comment = 0 if User.find(vote_part.user_id).username == user_name_for_votes }

    if @voted_comment == 0
      @return_string = "You and " + (@vote_list.length-1).to_s + " other people voted"
    else
      @return_string = " " << (@vote_list.length).to_s << " other people voted"
    end
    if @vote_list.length ==0
      @return_string = "0 people voted"

    end
    @return_string
  end

  def self.check_if_user_already_voted(username_from_view, post_id_to_check_vote)
   @voted_post_for_new  = 1
   @vote_list =  Vote.where(:post_flag => "1",:pc_vote_id => post_id_to_check_vote)
    @vote_list.each{|vote_part| @voted_post_for_new = 0 if User.find(vote_part.user_id).username == username_from_view }
   @voted_post_for_new
  end
  def self.check_if_user_already_voted_for_comment(username_from_view, comment_id_to_check_vote)
    @voted_for_comment_for_new  = 1
    @vote_list =  Vote.where(:post_flag => "0",:pc_vote_id =>comment_id_to_check_vote)
    @vote_list.each{|vote_part| @voted_for_comment_for_new = 0 if User.find(vote_part.user_id).username == username_from_view }
    @voted_for_comment_for_new
  end

end



