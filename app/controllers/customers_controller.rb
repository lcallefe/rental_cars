class CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = Customer.new
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
        redirect_to customers_path
    else
        render :edit
    end
  end
  
  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer
    else
      @customer = Customer.all
      render :new
    end
  end

  private
  def customer_params
    customer_params = params.require(:customer)
                             .permit(:name, :document, :email)
  end
end