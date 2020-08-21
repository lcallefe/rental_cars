class Car < ApplicationRecord
  belongs_to :subsidiary
  belongs_to :car_model
  validates :license_plate, :color, :car_model, 
            :mileage, :subsidiary, presence: true
  validates :license_plate, uniqueness: { case_sensitive: false }
  validates_numericality_of :mileage, :greater_than => 0
end
