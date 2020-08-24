require 'rails_helper'

feature 'Admin register car' do
  scenario 'and must be signed in' do
  
    visit new_car_path
    
    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'sucessfully' do
    car_category = CarCategory.create!(name: 'Top', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 50)
    car_model = CarModel.create!(name: 'Chevette', year: 1995, manufacturer: 'Chevrolet', 
                     motorization:'1.0', car_category: car_category, fuel_type: 'Gasolina')
    Subsidiary.create!(name: 'Brasilia', cnpj: '94.248.622/2882-61', address: 'Avenida 1234')
    user_login()
    
    visit root_path
    click_on 'Carros'
    click_on 'Registrar carro para frota'
    select 'Chevette', from: 'Modelo de carro'
    select 'Brasilia', from: 'Filial'
    fill_in 'Placa', with: 'ABC-1326'
    fill_in 'Cor', with: 'Prata'
    fill_in 'Quilometragem', with: '150000'
    click_on 'Cadastrar carro'

    expect(page).to have_content('Detalhes do carro')
    expect(page).to have_content('ABC-1326')
    expect(page).to have_content('Prata')
    expect(page).to have_content('Chevette')
    expect(page).to have_content('Brasilia')
    expect(page).to have_content('150000 km')
  end

  scenario 'must fill in all fields' do
    user_login()

    visit root_path
    click_on 'Carros'
    click_on 'Registrar carro para frota'
    click_on 'Cadastrar carro'

    expect(page).to have_content('Placa não pode ficar em branco')
    expect(page).to have_content('Cor não pode ficar em branco')
    expect(page).to have_content('Modelo de carro não pode ficar em branco')
    expect(page).to have_content('Filial não pode ficar em branco')
    expect(page).to have_content('Quilometragem não pode ficar em branco')
    expect(page).to have_content('Escolha um modelo de carro')
    expect(page).to have_content('Escolha uma filial')
  end
 
  scenario 'license_plate must be unique' do
    car_category = CarCategory.create!(name: 'Plus', daily_rate: 100, car_insurance: 50,
                                       third_party_insurance: 50)
    car_model = CarModel.create!(name: 'Monza', year: 1995, manufacturer: 'Chevrolet', 
                                 motorization:'1.0', car_category: car_category, fuel_type: 'Gasolina')
    subsidiary = Subsidiary.create!(name: 'Acre', cnpj: '16.353.536/7576-47', address: 'Avenida 1234')
    Car.create!(license_plate: 'CAR-6667', color: 'Prata', mileage: '150000', subsidiary: subsidiary, 
                car_model: car_model)
    user_login()

    visit root_path
    click_on 'Carros'
    click_on 'Registrar carro para frota'
    select 'Monza', from: 'Modelo de carro'
    select 'Acre', from: 'Filial'
    fill_in 'Placa', with: 'CAR-6667'
    fill_in 'Cor', with: 'Verde'
    fill_in 'Quilometragem', with: '20000'
    click_on 'Cadastrar carro'
   
    expect(page).to have_content('Placa já está em uso')
  end

  scenario 'mileage must be greater than zero' do
    car_category = CarCategory.create!(name: 'Plus', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 50)
    CarModel.create!(name: 'Monza', year: 1995, manufacturer: 'Chevrolet', 
                     motorization:'1.0', car_category: car_category, fuel_type: 'Gasolina')
    Subsidiary.create!(name: 'Acre', cnpj: CNPJ.generate(true), address: 'Avenida 1234')
    user_login()
    
    visit root_path
    click_on 'Carros'
    click_on 'Registrar carro para frota'
    select 'Monza', from: 'Modelo de carro'
    select 'Acre', from: 'Filial'
    fill_in 'Placa', with: 'ABC-6666'
    fill_in 'Cor', with: 'Prata'
    fill_in 'Quilometragem', with: '0'
    click_on 'Cadastrar carro'

    expect(page).to have_content('Quilometragem deve ser maior que 0')
  end
end

    