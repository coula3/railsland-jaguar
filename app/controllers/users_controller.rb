class UsersController < ApplicationController

  before_action :require_login, :set_action_access
  skip_before_action :require_login, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :admin_edit]
  before_action :set_action_access, only: [:show, :edit]

  def new
    @user = User.new
    redirect_to user_workspace_path if logged_in?
  end

  def create
    @user = Dealer.first.users.build(user_params)
    @user.status = "active" if @user.first_name.present? && @user.last_name.present?
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_workspace_path
    else
      render :new
    end
  end
  
  def index
    if current_user.admin
      @users = User.all.order(:first_name)
    else
      redirect_to user_workspace_path, notice: access_unauthorized_msg
    end
  end
  
  def show
    if @user.status == "active"
    else
      redirect_to user_workspace_path, notice: access_unauthorized_msg
    end
  end
  
  def edit
    if @user && (current_user != @user && current_user.admin)
      redirect_to admin_edit_path(@user)
    end
  end
  
  def update
    if (!@user.first_name.blank? || !@user.last_name.blank?) && params[:user][:password].blank?
      @user.first_name, @user.last_name = params[:user][:first_name], params[:user][:last_name]
      @user.valid?
      render :edit
    elsif @user.update(user_params)
      @user.update(admin: true) if User.count == 1
      @user.update(status: "active")
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
    if !current_user.admin
      redirect_to user_workspace_path, notice: access_unauthorized_msg
    elsif !@user
      redirect_to user_workspace_path, notice: "User ##{params[:id]} does not exist"
    else
    end
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

  def set_action_access
    if @user && (current_user != @user && !current_user.admin)
      redirect_to user_workspace_path, notice: "You are not authorized to access the data of User ##{params[:id]}."
    elsif !@user
      redirect_to user_workspace_path, notice: "User ##{params[:id]} does not exist"
    end
  end
end