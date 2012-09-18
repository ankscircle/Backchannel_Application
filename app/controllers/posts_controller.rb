class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  helper_method :update_post

  def index
    @edit_post_mode = "0"
    @edit_comment_mode = "0"
    @posts_from_home = Post.find(params[:post_id_from_view])
   if(params[:vote_bool]=="1")
      self.vote_post
   end
   if(params[:vote_bool]=="2")
     self.vote_comment
    end
   if(params[:edit_post]=="set")
     @edit_post_mode    ="1"
   end
    if(params[:edit_comment]=="set")
      @edit_comment_mode    ="1"
    end
  end



   def update_post
     Rails.logger.info('Update Post')
    Rails.logger.info(@edit_post_mode)
     pst = Post.find(params[:post_id_from_view])
     pst.content = params[:edit_post]
     pst.category_id = params[:category_to_edit][0]
     pst.save # is this save performing a update or insert?
     redirect_to :action => 'index',:post_id_from_view =>params[:post_id_from_view]

   end
  def update_comment

    pst = Comment.find(params[:comment_id_from_view])
    pst.comment = params[:edit_comment]
    pst.save # is this save performing a update or insert?
    redirect_to :action => 'index',:post_id_from_view =>params[:post_id_from_view]

  end

  def comment_create
    Rails.logger.info('came to HomeController/comment-->action')
    puts ":post_id => #{Post.find_by_id(params[:postid])}, :content => #{params[:create_comment]}"
    Rails.logger.info('came to HomeController/comment-->action')

    # create a new comment using the post information
    @new_comment = Comment.new(:comment=> params[:create_comment],:post_id => Post.find(params[:postid]),:user_id => User.find(session[:user_id]).id)
    @new_comment.save
    flash[:notice] = "You successfully created a new comment"
    flash[:color]= "valid"

    redirect_to :action => 'index',:post_id_from_view =>Post.find(params[:postid])
  end

  def comments_to_populate(post_id_for_comment)
    @comments_to_display =Comment.get_comment_by_id(post_id_for_comment)
    Rails.logger.info('came to HomeController/post-->action',@comments_to_display)
    @comments_to_display
  end
  helper_method :comments_to_populate


  def vote_post
    Rails.logger.info('Came to create new vote')
    if(Post.find(params[:post_id_from_view]).user_id !=(User.find(session[:user_id])).username )
      if(Vote.check_if_user_already_voted((User.find(session[:user_id])).username, params[:post_id_from_view])== 1)
      @new_vote = Vote.new(:pc_vote_id =>params[:post_id_from_view],:post_flag =>"1", :user_id => session[:user_id])
      @new_vote.save
      end
      end
  end
  helper_method :vote_post

  def vote_comment
    Rails.logger.info('Came to create new vote')
    if(User.find((Comment.find(params[:comment_id_for_new])).user_id).username !=(User.find(session[:user_id])).username )
      if(Vote.check_if_user_already_voted_for_comment((User.find(session[:user_id])).username, params[:comment_id_for_new])== 1)
        @new_vote = Vote.new(:pc_vote_id =>params[:comment_id_for_new],:post_flag =>"0", :user_id => (User.find(session[:user_id])).id)
    @new_vote.save
        end
    end
  end
  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end
end
