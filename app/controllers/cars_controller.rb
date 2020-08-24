class CarsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cars = Car.all
  end

  def show
    @car = Car.find(params[:id])
  end

  def new
    @car = Car.new
    @car_models = CarModel.all
    @subsidiaries = Subsidiary.all
  end

  def create
    car_params = params.require(:car)
                .permit(:license_plate, :color, :car_model_id, 
                        :mileage, :subsidiary_id)
    @car = Car.new(car_params)
    if @car.save
      redirect_to @car
    else
      @car_models = CarModel.all
      @subsidiaries = Subsidiary.all
      render :new
    end
  end
end