class UsersController < ApplicationController
  before_filter :save_login_state, :only => [:new, :create]
  # GET /users
  # GET /users.json
  def new
    @user = User.new
  end
  def create
    @user = User.new(params[:user])
    if @user.save

      flash[:notice] = "You Signed up successfully"
      flash[:color]= "valid"
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
    end
    redirect_to :controller => 'home',:action => 'index'
  end


end
