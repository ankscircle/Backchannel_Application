class AdminsController < ApplicationController
  # GET /admins
  # GET /admins.json
  def index
    @list_users = User.all
    if params[:destroy_user] == "1"
      self.delete_user
    end
    if params[:assign_role] == "1"
      self.role_assign
    end
    if params[:revoke_role] == "1"
      self.role_revoke
    end

  end
  # GET /admins/1
  # GET /admins/1.json
  def show
    Rails.logger.info('Comes in show')
    @post_vote_count =0
    @comment_vote_count =0
    usr = User.find(params[:user_show_report])
    @all_posts_of_usr = Post.where(:user_id => usr.id)
    @all_posts_of_usr.each{ |post|
    vote_each_post = Vote.where(:post_flag => "1",:pc_vote_id => post.id)
     @post_vote_count += vote_each_post.count
    }

    @all_comments_by_usr = Comment.where(:user_id => usr.id)
    @all_comments_by_usr.each{|cmt|
    vote_for_each_comment = Vote.where(:post_flag => "0",:pc_vote_id => cmt.id)
       @comment_vote_count += vote_for_each_comment.count
    }



  end

  # GET /admins/new
  # GET /admins/new.json
  def new
    @admin = Admin.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin }
    end
  end

  # GET /admins/1/edit
  def edit
    Rails.logger.info('Comes in edit')
    end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(params[:admin])

    respond_to do |format|
      if @admin.save
        format.html { redirect_to @admin, notice: 'Admin was successfully created.' }
        format.json { render json: @admin, status: :created, location: @admin }
      else
        format.html { render action: "new" }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admins/1
  # PUT /admins/1.json
  def update
    @admin = Admin.find(params[:id])

    respond_to do |format|
      if @admin.update_attributes(params[:admin])
        format.html { redirect_to @admin, notice: 'Admin was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def role_assign
    user = User.find(params[:assign_role_user])
    user.role = "1"
    user.save
    redirect_to :action=> 'index'
  end

  def role_revoke
    user = User.find(params[:revoke_role_user])
    user.role = "0"
    user.save
    redirect_to :action=> 'index'
  end
  def delete_user
    usr = User.find(params[:user_deleted])
    pst = Post.where(:user_id => usr.id)
    pst.each{|p| Post.delete_post_when_id_given(p.id)}
    Comment.del_comments_by_user(params[:user_deleted])
    Vote.delete_votes_by_a_user(params[:user_deleted])
    usr.destroy
    redirect_to :action=> 'index'
  end
  # DELETE /admins/1
  # DELETE /admins/1.json
  # destroy
  # @admin = Admin.find(params[:id])
  #@admin.destroy

  #respond_to do |format|
  # format.html { redirect_to admins_url }
  # format.json { head :ok }
  #end
  #end
end
