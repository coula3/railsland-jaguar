class CustomersController < ApplicationController
  before_action :require_login
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :set_action_access, only: [:new, :show, :index, :edit, :with_service_insurance]
  before_action :check_customer, only: [:show, :edit]

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
    customers = Customer.all

    if params[:q] && params[:q].blank?
      @customers = []
    elsif params[:q]
      @parameter = params[:q].downcase
      results = customers.where("lower(first_name) LIKE :search", search: "%#{@parameter}%").to_a.concat(customers.where("lower(last_name) LIKE :search", search: "%#{@parameter}%")).uniq
      @customers = results.sort_by { |result| result.last_name }
    else
      @customers = customers.sort_by {|customer| customer.last_name }
    end
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

  def check_customer
    if !Customer.exists?(params[:id])
      redirect_to customers_path, notice: non_existing_customer_msg
    end
  end
end
