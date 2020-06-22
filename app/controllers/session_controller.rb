class SessionController < ApplicationController
  def signin
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect_to user_workspace_path
    else
      render :signin
    end
  end

  def destroy
  end
end
