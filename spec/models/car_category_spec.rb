require 'rails_helper'

describe CarCategory, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      category = CarCategory.new

      category.valid?

      expect(category.errors[:name]).to include('não pode ficar em branco')
      expect(category.errors[:daily_rate]).to include('não pode ficar em '\
                                                      'branco')
      expect(category.errors[:third_party_insurance])
        .to include('não pode ficar em branco')
    end

    it 'name must be uniq' do
      CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                          third_party_insurance: 10.5)
      category = CarCategory.new(name: 'Top')

      category.valid?

      expect(category.errors[:name]).to include('já está em uso')
    end

    it 'must not contain whitespaces' do
      car_category = CarCategory.new(name: '    ', daily_rate: 105.5, car_insurance: 58.5,
                                     third_party_insurance: 10.5)

      car_category.valid?

      expect(car_category.errors[:name]).to include('não pode ficar em branco')
    end

    it 'uppercase and lowercase words are the same' do
      CarCategory.create!(name: 'TOp', daily_rate: 105.5, car_insurance: 58.5,
                          third_party_insurance: 10.5)
      car_category = CarCategory.new(name: 'toP', daily_rate: 105.5, car_insurance: 58.5,
                                     third_party_insurance: 10.5)

      car_category.valid?

      expect(car_category.errors[:name]).to include('já está em uso') 
    end 

    it 'name field must not allow special characters' do
      car_category = CarCategory.new(name: '@#$%^ara ketu^&', daily_rate: 105.5, car_insurance: 58.5,
                                     third_party_insurance: 10.5)
      car_category.valid?

      expect(car_category.errors[:name]).to include('não é válido')
    end 

    it 'name should be at least 3 characters long' do
      car_category = CarCategory.new(name: 'oi', daily_rate: 200.5, car_insurance: 33.8,
                                     third_party_insurance: 20.5)
      car_category.valid?

      expect(car_category.errors[:name]).to include('é muito curto (mínimo: 3 caracteres)')
    end 

    it 'first letter should be capitalized' do
      car_category = CarCategory.new(name: 'antigos e flex', daily_rate: 200.5, car_insurance: 33.8,
                                     third_party_insurance: 20.5)
      car_category.valid?

      expect(car_category.name).to eq 'Antigos E Flex'
    end   

    it 'third_party_insurance must be greater than zero' do
      car_category = CarCategory.new(name: 'antigos e flex', daily_rate: 200.5, car_insurance: 33.8,
                                     third_party_insurance: 0)
      car_category.valid?

      expect(car_category.errors[:third_party_insurance]).to include('deve ser maior que 0')
    end

    it 'car_insurance must be greater than zero' do
      car_category = CarCategory.new(name: 'antigos e flex', daily_rate: 200.5, car_insurance: 0,
                                     third_party_insurance: 100)
      car_category.valid?

      expect(car_category.errors[:car_insurance]).to include('deve ser maior que 0')
    end

    it 'daily_rate must be greater than zero' do
      car_category = CarCategory.new(name: 'antigos e flex', daily_rate: 0, car_insurance: 250,
                                     third_party_insurance: 100)
      car_category.valid?

      expect(car_category.errors[:daily_rate]).to include('deve ser maior que 0')
    end
  end
end
