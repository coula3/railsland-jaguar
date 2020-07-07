class ServicesController < ApplicationController
  before_action :require_login
  before_action :set_service, only: [:edit, :update, :destroy]
  
  def new
    if current_user.admin
      @service = Service.new
    else
      redirect_to user_workspace_path, notice: unauthorized_access_msg
    end
  end

  def create
    @service = Dealer.first.services.build(service_params)
    if @service.save
      redirect_to services_path
    else
      render :new
    end
  end

  def index
    @services = Service.order(:name)
    if current_user.status == "active"
    else
      redirect_to user_workspace_path, notice: unauthorized_access_msg
    end
  end

  def edit
    if !Service.exists?(params[:id])
      redirect_to services_path, notice: "Service does not exist"
    elsif current_user.admin
    else
      redirect_to user_workspace_path, notice: unauthorized_access_msg
    end
  end

  def update
    if @service.update(service_params)
      redirect_to services_path
    else
      render :edit
    end
  end

  def destroy
    @service.destroy

    redirect_to services_path
  end

  private

  def service_params
    params.require(:service).permit(:name)
  end

  def require_login
    return head(:forbidden) unless session.include? :user_id
  end

  def set_service
    @service = Service.find_by(id: params[:id])
  end
end
