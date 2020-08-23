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

    it 'must not contain whitespaces' do
      category = CarCategory.create!(name: 'Usados', daily_rate: 105.5, car_insurance: 58.5,
                          third_party_insurance: 10.5)
      car_model = CarModel.new(name: '  ', year: 2002, manufacturer: '  ', 
                          motorization:'1.0', car_category: category, fuel_type: 'Flex')

      car_model.valid?

      expect(car_model.errors[:name]).to include('não pode ficar em branco')
      expect(car_model.errors[:manufacturer]).to include('não pode ficar em branco')
    end

    it 'uppercase and lowercase words are the same' do
      category = CarCategory.create!(name: 'Usados', daily_rate: 105.5, car_insurance: 58.5,
                          third_party_insurance: 10.5)
      CarModel.create!(name: 'FIesTa', year: 2002, manufacturer: 'Ford', 
                          motorization:'1.0', car_category: category, fuel_type: 'Flex')
      car_model = CarModel.new(name: 'FIesta', year: 2002, manufacturer: 'Ford', 
                          motorization:'1.0', car_category: category, fuel_type: 'Flex')

      car_model.valid?

      expect(car_model.errors[:name]).to include('já está em uso') 
    end 

    it 'name and manufacturer fields must not allow special characters' do
      category = CarCategory.create!(name: 'Usados', daily_rate: 105.5, car_insurance: 58.5,
                          third_party_insurance: 10.5)
      car_model = CarModel.new(name: '$%^&', year: 2002, manufacturer: '!!@ola%^', 
                          motorization:'1.0', car_category: category, fuel_type: 'Flex')
      car_model.valid?

      expect(car_model.errors[:name]).to include('não é válido')
      expect(car_model.errors[:manufacturer]).to include('não é válido')
    end 

    it 'name should be at least 2 characters long' do
      category = CarCategory.new(name: 'Usados', daily_rate: 200.5, car_insurance: 33.8,
                                     third_party_insurance: 20.5)
      car_model = CarModel.new(name: 'A', year: 2002, manufacturer: 'Ford', 
                               motorization:'1.0', car_category: category, fuel_type: 'Flex')
      car_model.valid?

      expect(car_model.errors[:name]).to include('é muito curto (mínimo: 2 caracteres)')
    end 

    it 'manufacturer should be at least 3 characters long' do
      category = CarCategory.new(name: 'Usados', daily_rate: 200.5, car_insurance: 33.8,
                                     third_party_insurance: 20.5)
      car_model = CarModel.new(name: 'oi', year: 2002, manufacturer: 'ui', 
                               motorization:'1.0', car_category: category, fuel_type: 'Flex')
      car_model.valid?

      expect(car_model.errors[:manufacturer]).to include('é muito curto (mínimo: 3 caracteres)')
    end

    it 'first letter should be capitalized' do
      category = CarCategory.new(name: 'Usados', daily_rate: 200.5, car_insurance: 33.8,
                                     third_party_insurance: 20.5)
      car_model = CarModel.create(name: 'tempra', year: 1995, manufacturer: 'fiat', 
                               motorization:'1.0', car_category: category, fuel_type: 'Flex')

      expect(car_model.name).to eq 'Tempra'
      expect(car_model.manufacturer).to eq 'Fiat'
    end   

    it 'fuel_type must be Álcool, Flex or Gasolina' do
      category = CarCategory.new(name: 'Usados', daily_rate: 200.5, car_insurance: 33.8,
                                     third_party_insurance: 20.5)
      car_model = CarModel.create(name: 'tempra', year: 1995, manufacturer: 'fiat', 
                               motorization:'1.0', car_category: category, fuel_type: 'diferente')

      expect(car_model.errors[:fuel_type]).to include('Insira um tipo de combustível válido: Gasolina, Álcool ou Flex')
    end 
  end
end

