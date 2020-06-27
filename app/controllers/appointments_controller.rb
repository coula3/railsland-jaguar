class AppointmentsController < ApplicationController
  before_action :require_login

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
      redirect_to customer_appointments_path(@appointment.customer)
    else
      @customer = Customer.find_by(id: appt_params[:customer_id])
      redirect_to new_customer_appointment_path(@customer)
    end
  end

  def show
    # /customers/:customer_id/appointments/:id(.:format)
    if params[:customer_id]
      @customer = Customer.find_by(id: params[:customer_id])
      if @customer.nil?
        redirect_to customers_path, alert: "Customer does not exist"
      else
        @appointment = @customer.appointments.find_by(id: params[:id])
      end  
    else
      @appointment = Appointment.find_by(id: params[:id])
    end
  end

  def index
    if params[:customer_id]
      @customer = Customer.find_by(id: params[:customer_id])
      if @customer.nil?
        redirect_to customers_path, alert: "Customer does not exist"
      else
        @appointments = @customer.appointments.order(:date)
      end
    else
      @appointments = Appointment.all.order(:date)
    end
  end

  def edit
    if params[:customer_id]
      @customer = Customer.find_by(id: params[:customer_id])
      if @customer.nil?
        redirect_to customers_path, alert: "Customer does not exist"
      else
        @appointment = @customer.appointments.find_by(id: params[:id])
      end  
    else
      @appointment = Appointment.find_by(id: params[:id])
    end
  end

  def update
    @appointment = Appointment.find_by(id: params[:id])
    if @appointment.update(appointment_params)
      redirect_to customer_appointments_path(@appointment.customer)
    else
      render :edit
    end
  end

  def destroy
    @appointment = Appointment.find_by(id: params[:id])
    @appointment.destroy
    redirect_to customer_appointments_path(@appointment.customer)
  end

  private

  def appointment_params
    params.require(:appointment).permit(:date, :time, :veh_model, :model_year, :status, :customer_id, :service_id) 
  end

  def require_login
    return head(:forbidden) unless session.include? :user_id
  end
end