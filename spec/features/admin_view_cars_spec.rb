require 'rails_helper'

feature 'Admin view cars' do
  scenario 'and must be signed in' do
  
    visit root_path
    click_on 'Carros'
    
    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'and view list' do
    car_category = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                                       third_party_insurance: 10.5)
    car_model = CarModel.create!(name: 'Corsa', year: 2000, manufacturer: 'Chevrolet', 
                                 motorization:'1.0', car_category: car_category, fuel_type: 'Gasolina')
    subsidiary = Subsidiary.create!(name: 'Brasilia', cnpj: CNPJ.generate(true), address: 'Avenida 1234')
    car = Car.create!(license_plate: 'BMP-1586', color: 'Amarelo', car_model: car_model, mileage:'80000', 
                      subsidiary: subsidiary)
    user_login()

    visit root_path
    click_on 'Carros'

    expect(page).to have_content('Corsa - 2000')
    expect(page).to have_content('Quilometragem - 80000 km')
  end

  scenario 'and view details' do
    car_category = CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                                       third_party_insurance: 10.5)
    car_model = CarModel.create!(name: 'Corsa', year: 2000, manufacturer: 'Chevrolet', 
                                 motorization:'1.0', car_category: car_category, fuel_type: 'Gasolina')
    subsidiary = Subsidiary.create!(name: 'Brasilia', cnpj: CNPJ.generate(true), address: 'Avenida 1234')
    car = Car.create!(license_plate: 'BMP-1586', color: 'Amarelo', car_model: car_model, mileage:'80000', 
                      subsidiary: subsidiary)
    user_login()

    visit root_path
    click_on 'Carros'
    click_on 'Corsa - 2000'

    expect(page).to have_content('Detalhes do carro')
    expect(page).to have_content('BMP-1586')
    expect(page).to have_content('Amarelo')
    expect(page).to have_content(car.car_model.name)
    expect(page).to have_content(car.subsidiary.name)
    expect(page).to have_content('80000')
    expect(page).to have_content(car.car_model.year)

  end

  scenario 'and no car is registered' do
    user_login()
    
    visit root_path
    click_on 'Carros'
    
    expect(page).to have_content('Nenhum carro cadastrado')
  end
end