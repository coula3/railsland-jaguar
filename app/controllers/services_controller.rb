class ServicesController < ApplicationController
  before_action :require_login
  before_action :set_service, only: [:edit, :update, :destroy]
  
  def new
    @service = Service.new
  end

  def create
    @service = Dealer.first.services.create(service_params)
    if @service
      redirect_to services_path
    else
      render :new
    end
  end

  def index
    @services = Service.all
  end

  def edit
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
