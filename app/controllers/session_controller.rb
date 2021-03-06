class SessionController < ApplicationController

  before_filter :authenticate_user, :only => [:home, :profile, :setting]
  before_filter :save_login_state, :only => [:login, :login_attempt]

  def login
  end
  def login_attempt
    authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
    #flash[:notice] = "Welcome to Backchannel"

    if authorized_user
      session[:user_id] = authorized_user.id
      Rails.logger.info('LOGGED IN')
      flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.username}"
      if authorized_user.role
        @admin_interface = authorized_user.role
      else
        @admin_interface = nil

      end
      redirect_to :controller => 'home',:action => 'index'
    else
      flash[:notice] = "Invalid Username or Password"
      Rails.logger.info('LOGGED FAILED')

      flash[:color]= "invalid"
      redirect_to :controller => 'home',:action => 'index'
    end
  end
  def logout
    session[:user_id] = nil
    redirect_to :controller => 'home',:action => 'index'
  end
  def home
  end

  def profile
  end

  def setting
  end

end
