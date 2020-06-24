class ServicesController < ApplicationController
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

  def show
  end

  def edit
    @service = Service.find(params[:id])
  end

  def update
    @service = Service.find(params[:id])
    if @service.update(service_params)
      redirect_to services_path
    else
      render :edit
    end
  end

  def destroy
    @service = Service.find(params[:id])
    @service.destroy

    redirect_to services_path
  end

  private

  def service_params
    params.require(:service).permit(:name)
  end
end
