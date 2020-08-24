class CarModel < ApplicationRecord
  belongs_to :car_category
  validates :name, :year, :manufacturer, :motorization,
              :fuel_type, :car_category_id, presence: true
  validates :name, length: { minimum: 2 }
  validates :manufacturer, length: { minimum: 3 }
  validates :name, uniqueness: { case_sensitive: true }
  validates_uniqueness_of :name, :scope => :car_category_id, :message => 'Modelo de carro já existente para a categoria'
  validates_format_of :name, :manufacturer, :with => /\A[^\s]+[-a-zA-Z\s]+([-a-zA-Z]+)*\Z/, :message => "não é válido"
  validates :fuel_type, inclusion: { in: %w(Álcool Alcool Flex Gasolina),
                        message: "Insira um tipo de combustível válido: Gasolina, Álcool ou Flex" }

  def name=(name)
    write_attribute(:name, name.to_s.downcase.titleize)
  end

  def manufacturer=(manufacturer)
    write_attribute(:manufacturer, manufacturer.to_s.downcase.titleize)
  end

  def fuel_type=(fuel_type)
    write_attribute(:fuel_type, fuel_type.to_s.capitalize)
  end
end
