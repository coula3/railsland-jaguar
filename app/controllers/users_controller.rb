class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # raise params.inspect
    @user = Dealer.first.users.build(user_params)
    if @user.save
      session[:id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end
  
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
