class DealersController < ApplicationController
  before_action :set_dealer

  def edit
    if current_user.admin
    else
      redirect_to user_workspace_path, notice: unauthorized_access_msg
    end
  end

  def update
    if @dealer.update(dealer_params)
      redirect_to user_workspace_path
    else
      render :edit
    end
  end

  private

  def dealer_params
    params.require(:dealer).permit(:name, :address, :city, :state, :zip, :telephone, :ext_one, :ext_two, :ext_three)
  end

  def set_dealer
    @dealer = Dealer.find_by(id: params[:id])
  end
end
