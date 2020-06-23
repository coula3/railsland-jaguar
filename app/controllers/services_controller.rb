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
  end

  def update
  end

  def destroy
  end

  private

  def service_params
    params.require(:service).permit(:name)
  end
end
