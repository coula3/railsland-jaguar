class UsersController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:new, :create]

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
    @users = User.all.order(:first_name)
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
      @user.update(admin: true) if User.count == 1
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  def destroy
    @user = User.find_by(id: params[:id])
    if @user.admin && !@user.admin_deletable?
      redirect_to users_path
    else
      @user.destroy
      redirect_to users_path
    end
  end
  
  def workspace
    @user = current_user
  end

  def admin_edit
    @user = User.find_by(id: params[:id])
  end

  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :position, :email, :password, :status, :admin)
  end

  def require_login
    return head(:forbidden) unless session.include? :user_id
  end
end
