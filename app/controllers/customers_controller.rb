class CustomersController < ApplicationController
  before_action :require_login
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :set_action_access, only: [:new, :show, :index, :edit, :with_service_insurance]
  
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
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to @customer
    else
      render :edit
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_path
  end

  def with_service_insurance
    @customers_with_service_insurance = Customer.with_service_insurance
    if @customers_with_service_insurance.size == 0
      redirect_to user_workspace_path, notice: "No customer with service insurance"
    else
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :telephone, :service_insurance)
  end

  def require_login
    return head(:forbidden) unless session.include? :user_id
  end

  def set_customer
    @customer = Customer.find_by(id: params[:id])
  end

  def set_action_access
    if current_user.status == "active"
    else
      redirect_to user_workspace_path, notice: unauthorized_access_msg
    end
  end
end
