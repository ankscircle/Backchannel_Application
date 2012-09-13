require 'will_paginate/array'
class HomesController < ApplicationController
  # GET /homes
  # GET /homes.json
  def index
    if !session[:user_id]                           # if there is no user
      @mode = "anonymous"                               # default the user mode to the 'a nobody' case
      @user = nil
    else                                             # if there is a user
      @mode = User.find(session[:user_id]).role    # find his role and make it available to the view
      @user = User.find(session[:user_id]).username
                                                    #puts "mode: #{@mode}"
    end
                      # if there is no ':search' value
    @post_try = Post.get_all_the_posts
    @posts_to_display = @post_try.paginate(:page =>params[:page],:per_page => 7)


    #--fetches 20 records
    #  @posts_to_display = @posts_to_display.paginate(:page => params[:page], :per_page => 20)
                                        # else find the ones he wants


    #  @threads = Post.find_some_threads(params[:search])
     # @threads = @threads.paginate(:page => params[:page], :per_page => 20)


    # base which posts are displayed by what the user searches (or doesn't search) for

  end

  def posts_to_display

   end

  def post_create
    Rails.logger.info('came to HomeController/post-->action')
    # the html checks for the user, but we double check here
    unless !session[:user_id]
      puts ":user_id #{User.find(session[:user_id]).username}, :content => #{params[:create_post]}"
      Rails.logger.info('came to HomeController/post-->action')

      # create a new post using the users information: because he entered it in the post box, their is no parent
      @new_post = Post.new(:user_id => User.find(session[:user_id]).username, :content => params[:create_post])
      @new_post.save
      flash[:notice] = "You successfully created a new post"
      flash[:color]= "valid"
    end
    redirect_to :action => 'index'
  end
  # GET /homes/1
  # GET /homes/1.json
  def show

  end

  # GET /homes/new
  # GET /homes/new.json
  def new

  end

  # GET /homes/1/edit
  def edit
  end

  # POST /homes
  # POST /homes.json
  def create

  end

  # PUT /homes/1
  # PUT /homes/1.json
  def update

  end

  # DELETE /homes/1
  # DELETE /homes/1.json
  def destroy

  end
  end

