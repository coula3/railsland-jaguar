class UsersController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :admin_edit]

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
  end
  
  def edit
  end
  
  def update
    if (!@user.first_name || !@user.last_name) && params[:user][:password].empty?
      @user.first_name, @user.last_name = params[:user][:first_name], params[:user][:last_name]
      # flash [:msg]
      render :edit
    elsif @user.update(user_params)
      @user.update(admin: true) if User.count == 1
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  def destroy
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
  end

  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :position, :email, :password, :status, :admin)
  end

  def require_login
    return head(:forbidden) unless session.include? :user_id
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end
end
