class CustomersController < ApplicationController
  before_action :require_login
  
  def new
    @customer = Customer.new
  end

  def create
    @customer = Dealer.first.customers.build(customer_params)
    if @customer.save
      redirect_to customer_path(@customer)
    else
      render :new
    end
  end

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to @customer
    else
      render :edit
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to customers_path
  end

  def with_service_insurance
    @customers_with_service_insurance = Customer.with_service_insurance
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :telephone, :service_insurance)
  end

  def require_login
    return head(:forbidden) unless session.include? :user_id
  end
end
