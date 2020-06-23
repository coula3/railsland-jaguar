class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = Dealer.first.users.build(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_workspace_path
    else
      render :new
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    if @user.admin && !@user.is_deletable?
      redirect_to users_path
    else
      @user.destroy
      redirect_to users_path
    end
  end

  def workspace
    @user = current_user
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :position, :email, :password)
  end
end
