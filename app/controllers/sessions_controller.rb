class SessionsController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:new, :create]
  
  def new
    @user = User.new
    redirect_to user_workspace_path if logged_in?
  end

  def create
    if auth
      @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.first_name = auth['info']['first_name']
        u.last_name = auth['info']['last_name']
        u.email = auth['info']['email']
        u.image = auth['info']['image']
        u.password = SecureRandom.hex
        u.dealer_id = dealer.id
      end

      if @user && @user.status == "deactivated"
        redirect_to root_path, notice: "User account deactivated"
      else
        session[:user_id] = @user.id
        render 'users/workspace'
      end
    else
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password]) && user.is_activated?
        session[:user_id] = user.id
        redirect_to user_workspace_path
      elsif user && user.status == "deactivated"
          redirect_to root_path, notice: "User account deactivated"
      elsif (user || !user) && (!params[:email].empty? || !params[:password].empty?)
        redirect_to root_path, notice: "Invalid email or password"
      else
        @user = User.create(dealer_id: dealer.id)
        render :new
      end
    end
  end
  
  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end

  def require_login
    return head(:forbidden) unless session.include? :user_id
  end
end
