class SessionController < ApplicationController

  before_filter :authenticate_user, :only => [:home, :profile, :setting]
  before_filter :save_login_state, :only => [:login, :login_attempt]

  def login
  end
  def login_attempt
    authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      Rails.logger.info('LOGGED IN')
      flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.username}"
      redirect_to(:action => 'home')
    else
      flash[:notice] = "Invalid Username or Password"
      Rails.logger.info('LOGGED FAILED')

      flash[:color]= "invalid"
      render "users/new"
    end
  end
  def logout
    session[:user_id] = nil
    redirect_to :action => 'login'
  end
  def home
  end

  def profile
  end

  def setting
  end

end
