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

    if @user.save
      session[:user_id] = @user.id
      redirect_to user_workspace_path
    else
      @user_errors = get_user_errors_hash(@user.errors.full_messages)
      render :new
    end
  end
  
  def index
    if current_user.admin
      @users = User.order(:last_name)
    else
      redirect_to user_workspace_path, notice: unauthorized_access_msg
    end
  end
  
  def show
    if @user.status == "active"
    else
      redirect_to user_workspace_path, notice: inactive_user_msg(@user)
    end
  end
  
  def edit
    if @user && (current_user != @user && current_user.admin)
      redirect_to admin_edit_path(@user)
    end
  end
  
  def update 
    new_inactive_user ||= @user.new_inactive_user
   
    if @user.update(user_params)
      @user.update(admin: true) if new_inactive_user && User.count == 1
      @user.update(status: "active") if new_inactive_user
      redirect_to user_path(@user)
    else
      if params[:user][:full_name]
        render :admin_edit 
      else
        @user_errors = get_user_errors_hash(@user.errors.full_messages)
        render :edit
      end
    end
  end
  
  def destroy
    if @user.admin && !@user.admin_deletable?
      redirect_to users_path, notice: "There must be at least two (02) active administrators in the system"
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
      redirect_to user_workspace_path, notice: unauthorized_access_msg
    elsif !@user
      redirect_to user_workspace_path, notice: "User ##{params[:id]} does not exist"
    else
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :sys_role, :email, :password, :password_confirmation, :status, :admin)
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
    elsif current_user.status == "inactive" && !@user
      redirect_to user_workspace_path, notice: unauthorized_access_msg
    elsif !@user
      redirect_to user_workspace_path, notice: "User ##{params[:id]} does not exist"
    end
  end

  def get_user_errors_hash(user_errors)
    errors_hash = {}
    user_errors.uniq.each do |error|
      errors_hash[:first_name] = error if error.include?("First name")
      errors_hash[:last_name] = error if error.include?("Last name")
      errors_hash[:email] = error if error.include?("Email") || error.include?("email")
      errors_hash[:password] = error if error.include?("Password")
    end
    errors_hash
  end
end