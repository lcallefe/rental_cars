class CarCategoriesController < ApplicationController
    def index
        @car_categories = CarCategory.all
        
    end

    def show
        @car_category = CarCategory.find(params[:id])
    end

    def new
        @car_category = CarCategory.new 
    end

    def create 
        car_category_params = params.require(:car_category)
                                    .permit(:name, :daily_rate, :car_insurance, :third_party_insurance)
        @car_category = CarCategory.new (car_category_params) 
        if @car_category.save
            redirect_to car_category_path(id: @car_category.id)
        else
            #redirect_to new_car_category_path
            render :new
        end
    end
end