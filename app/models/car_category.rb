class CarCategory < ApplicationRecord
  validates :name, :daily_rate, :car_insurance,
            :third_party_insurance, presence: true
  validates :name, uniqueness: true
  validates :name, length: { minimum: 3 }
  validates_format_of :name, :with => /\A[^\s]+[-a-zA-Z\s]+([-a-zA-Z]+)*\Z/, :message => "não é válido"

  def name=(name)
    write_attribute(:name, name.to_s.titleize)
  end

  def daily_price
    car_insurance + third_party_insurance + daily_rate
  end
end
