class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :car_category
  belongs_to :user
end
