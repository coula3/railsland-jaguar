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
    # raise "...at customers destroy!".inspect
    @customer = Customer.find(params[:id])
    # byebug
    @customer.destroy
    redirect_to customers_path
  end

  private
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :telephone)
  end
end
