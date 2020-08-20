require 'rails_helper'

require 'rails_helper'

describe CarModel, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      car_model = CarModel.new

      car_model.valid?

      expect(car_model.errors[:name]).to include('não pode ficar em branco')
      expect(car_model.errors[:year]).to include('não pode ficar em branco')
      expect(car_model.errors[:motorization]).to include('não pode ficar em branco')
      expect(car_model.errors[:fuel_type]).to include('não pode ficar em branco')
      expect(car_model.errors[:car_category_id]).to include('não pode ficar em branco')

    end

    it 'car model name must be uniq for car category' do
      category = CarCategory.create!(name: 'Duplicada', daily_rate: 105.5, car_insurance: 58.5,
                          third_party_insurance: 10.5)
      CarModel.create!(name: 'Fiesta', year: 2002, manufacturer: 'Ford', 
                          motorization:'1.0', car_category: category, fuel_type: 'Flex')
      car_model = CarModel.new(name: 'Fiesta', year: 2005, manufacturer: 'Volkswagen', 
                          motorization:'1.6', car_category: category, fuel_type: 'Gasolina')

      car_model.valid?

      expect(car_model.errors[:name]).to include('Modelo de carro já existente para a categoria')
    end

  end
end

