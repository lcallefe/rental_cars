require 'rails_helper'

feature 'Admin view car models for a given category' do
  scenario 'and must be signed in' do
  
    visit root_path
    click_on 'Categorias'
    
    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'successfully' do
    car_category = CarCategory.create!(name: 'Master', daily_rate: 200, car_insurance: 50,
                                           third_party_insurance: 20)
    CarModel.create!(name: 'Chevette', year: 1974, manufacturer: 'Chevrolet', 
                     motorization:'1.6', car_category: car_category, fuel_type: 'Alcool')
    user_login()

    visit root_path
    click_on 'Categorias'
    click_on 'Master'
  
    expect(page).to have_content('Modelos de carro para esta categoria')
    expect(page).to have_content('Chevette - 1974')
    expect(page).to have_content('Chevrolet')
    expect(page).to have_content('Master')
  end

  scenario 'and there is more than one car model for that car category' do
    car_category = CarCategory.create!(name: 'Antigos', daily_rate: 200, car_insurance: 50,
                                           third_party_insurance: 20)
    CarModel.create!(name: 'Kadett', year: 1995, manufacturer: 'Chevrolet', 
                     motorization:'1.6', car_category: car_category, fuel_type: 'Alcool')
    CarModel.create!(name: 'Corcel Luxo', year: 1977, manufacturer: 'Ford', 
                     motorization:'1.3', car_category: car_category, fuel_type: 'Alcool')
    CarModel.create!(name: 'Voyage', year: 1994, manufacturer: 'Volkswagen', 
                     motorization:'1.8', car_category: car_category, fuel_type: 'Gasolina')
    user_login()

    visit root_path
    click_on 'Categorias'
    click_on 'Antigos'
  
    expect(page).to have_content('Modelos de carro para esta categoria')
    expect(page).to have_content('Kadett - 1995')
    expect(page).to have_content('Chevrolet')
    expect(page).to have_content('Corcel Luxo - 1977')
    expect(page).to have_content('Ford')
    expect(page).to have_content('Voyage - 1994')
    expect(page).to have_content('Volkswagen')
  end

  scenario 'and car category has no car model associated with' do
    car_category = CarCategory.create!(name: 'Novos', daily_rate: 100, car_insurance: 50,
                                           third_party_insurance: 20)
    user_login()

    visit root_path
    click_on 'Categorias'
    click_on 'Novos'

    expect(page).to have_content('Nenhum modelo de carro cadastrado')
  end 

  scenario 'and view car model details' do
    car_category = CarCategory.create!(name: 'Econômicos', daily_rate: 100, car_insurance: 50,
                                           third_party_insurance: 20)
    CarModel.create!(name: 'Fiesta', year: 2002, manufacturer: 'Ford', 
                     motorization:'1.0', car_category: car_category, fuel_type: 'Flex')
    CarModel.create!(name: 'Gol', year: 2005, manufacturer: 'Volkswagen', 
                     motorization:'1.0', car_category: car_category, fuel_type: 'Flex')
    user_login()
    
    visit root_path
    click_on 'Categorias'
    click_on 'Econômicos'
    click_on 'Fiesta - 2002'
    
    expect(page).to have_content('Fiesta')
    expect(page).to have_content('2002')
    expect(page).to have_content('Ford')
    expect(page).to have_content('1.0')
    expect(page).to have_content(car_category.name)
    expect(page).to have_content('Flex')
    expect(page).not_to have_content('Gol')
    expect(page).not_to have_content('Volkswagen')
  end 
end