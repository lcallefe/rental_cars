require 'rails_helper'

feature 'Admin view car models for a given category' do
  scenario 'successfully' do
    car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 50,
                                           third_party_insurance: 20)
    CarModel.create!(name: 'Chevette', year: 1974, manufacturer: 'Chevrolet', 
                     motorization:'1.6', car_category: car_category, fuel_type: 'Alcool')

    visit root_path
    click_on 'Categorias'
    click_on 'Top'
    click_on 'Ver modelos para esta categoria'

    expect(page).to have_content('Chevette')
    expect(page).to have_content('1974')
    expect(page).to have_content('Chevrolet')
    expect(page).to have_content('Top')
    expect(current_path).to eq car_models_path
  end

  xscenario 'and there is more than one car model for that car category' do
    
  end

  xscenario 'and car category has no car model associated with' do

  end 

end