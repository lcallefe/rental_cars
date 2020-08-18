class CarModel < ApplicationRecord
  belongs_to :car_category
  validates :name, :year, :manufacturer, :motorization,
              :fuel_type, :car_category_id, presence: true
  validates_uniqueness_of :name, :scope => :car_category_id, :message => 'Modelo de carro já existente para a categoria'
end
