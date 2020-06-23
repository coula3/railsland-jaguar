class SessionController < ApplicationController
  def new
  end

  def create
    if auth
      @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.email = auth['info']['email']
        u.image = auth['info']['image']
        u.password = SecureRandom.hex
        u.dealer_id = Dealer.first.id
      end

      session[:user_id] = @user.id
      render 'users/workspace'

    else
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to user_workspace_path
      else
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
end
