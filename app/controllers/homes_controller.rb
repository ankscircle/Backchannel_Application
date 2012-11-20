class HomesController < ApplicationController
  # GET /homes
  # GET /homes.json

  def index
    if !session[:user_id]                           # if there is no user
      @mode = "anonymous"                               # default the user mode to the 'a nobody' case
      @user = nil
    else

# if there is a user
      @mode = User.find(session[:user_id]).role    # find his role and make it available to the view
      @user = User.find(session[:user_id]).username
                                                    #puts "mode: #{@mode}"
    end
    @search_hint = "false"

    #@new_admin = User.new(:username => "admin", :password => "admin123",:email => "admin@gmail.com",:role => "1")
    #@new_admin.save

    #@search_results = "init"
    #@new_category = Category.new(:name => "Sports")
    # @new_category.save
    #@new_category1 = Category.new(:name => "Science")
    #@new_category1.save


    @posts_to_display = Post.get_all_the_posts
    @categories_to_populate = Category.all


  end

  def search_post
    Rails.logger.info("Searching....")
    @posts_to_display1 = Post.search_all_post(params[:search])
   @posts_to_display = Post.find(@posts_to_display1)
    @search_hint = "true"
    render :action => 'index'
end


  def post_create
    Rails.logger.info('came to HomeController/post-->action')
    # the html checks for the user, but we double check here
    unless !session[:user_id]
      puts ":user_id #{User.find(session[:user_id]).username}, :content => #{params[:create_post]},:category_id=> #{params[:category_to_pass][0]}"
      Rails.logger.info('Categories:::')
      Rails.logger.info(params[:category_to_pass][0])

      # create a new post using the users information: because he entered it in the post box, their is no parent
      @new_post = Post.new(:user_id => User.find(session[:user_id]).id, :content => params[:create_post],:category_id=> params[:category_to_pass][0])
      puts @new_post.save
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

