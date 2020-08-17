class CarModel < ApplicationRecord
  belongs_to :car_category
  validates :name, :year, :manufacturer, :motorization,
              :fuel_type, :car_category_id, presence: true
end
