class AppointmentsController < ApplicationController
  def new
    if params[:customer_id] && !Customer.exists?(params[:customer_id])
      redirect_to customers_path, alert: "Customer does not exist"
    else
      @appointment = Appointment.new(customer_id: params[:customer_id])
      @customer = Customer.find_by(id: params[:customer_id])
    end
  end

  def create
    @appointment = Appointment.new(date: appt_params[:date], time: appt_params[:time], veh_model: appt_params[:veh_model], model_year: appt_params[:model_year], status: appt_params[:status], customer_id: appt_params[:customer_id], service_id: serv_params[:service_id])
    if @appointment.save
      redirect_to appointments_path
    else
      @customer = Customer.find_by(id: appt_params[:customer_id])
      redirect_to new_customer_appointment_path(@customer)
    end
  end

  def show
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def appt_params
    params.require(:appointment).permit(:date, :time, :veh_model, :model_year, :status, :customer_id) 
  end

  def serv_params
    params.require(:service).permit(:service_id)
  end
end
