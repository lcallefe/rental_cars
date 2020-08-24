class RentalsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rentals = Rental.all
  end
  
  def show
    @rentals = Rental.find(params[:id])
  end

  def new
    @rental = Rental.new
    @customers = Customer.all
    @car_categories = CarCategory.all
  end

  def create
    @rental = Rental.new(rental_params)
    @rental.user = current_user
    @rental.save
    redirect_to @rental, notice: 'Agendamento realizado com sucesso'
  end
  private 
  def rental_params
    params.require(:rental)
          .permit(:start_date, :end_date, 
                  :customer_id, :car_category_id)
  end
end