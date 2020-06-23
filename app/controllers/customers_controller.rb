class CustomersController < ApplicationController
  def new
    @customer = Customer.new
  end

  def create
    @customer = Dealer.first.customers.build(customer_params)
    if @customer.save
      redirect_to customers_path
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
  end

  def destroy
  end

  private
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :telephone)
  end
end
