class Car < ApplicationRecord
  belongs_to :subsidiary
  belongs_to :car_model
end
