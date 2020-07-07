class AppointmentsController < ApplicationController
  before_action :require_login
  before_action :set_action_access, only: [:new, :show, :index, :edit]

  def new
    if params[:customer_id] && !Customer.exists?(params[:customer_id])
      redirect_to customers_path, notice: non_existing_customer_msg
    else
      @appointment = Appointment.new(customer_id: params[:customer_id])
      @customer = Customer.find_by(id: params[:customer_id])
    end
  end

  def create
    @customer = Customer.find_by(id: appointment_params[:customer_id])
    @appointment = @customer.appointments.build(appointment_params)
    
    if @appointment.save
      redirect_to customer_appointments_path(@appointment.customer)
    else
      render :new
    end
  end

  def show
    if params[:customer_id]
      @customer = Customer.find_by(id: params[:customer_id])
      if @customer.nil?
        redirect_to customers_path, notice: non_existing_customer_msg
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
        redirect_to customers_path, notice: non_existing_customer_msg
      elsif @customer.appointments.size == 0
        redirect_to customer_path(@customer), notice: "No appointment record"
      else
        @appointments = @customer.appointments.order(:date)
      end
    else
      @appointments = Appointment.order(:date)
    end
  end

  def edit
    if params[:customer_id]
      @customer = Customer.find_by(id: params[:customer_id])
      if @customer.nil?
        redirect_to customers_path, notice: non_existing_customer_msg
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
      @customer = Customer.find_by(id: appointment_params[:customer_id])
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

  def set_action_access
    if current_user.status == "active"
    else
      redirect_to user_workspace_path, notice: unauthorized_access_msg
    end
  end
end