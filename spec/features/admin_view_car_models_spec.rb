require 'rails_helper'

feature 'Admin view car models' do
    scenario 'and view list' do
        car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 50,
                                           third_party_insurance: 20)
        CarModel.create!(name: 'KA', year: 2019, manufacturer: 'Ford', 
                         motorization:'1.0', car_category: car_category, fuel_type: 'Flex')
        CarModel.create!(name: 'Onix', year: 2020, manufacturer: 'Chevrolet', 
                         motorization:'1.0', car_category: car_category, fuel_type: 'Flex')

        visit root_path
        click_on 'Modelos de carro'

        expect(page).to have_content('KA')
        expect(page).to have_content('Ford')
        expect(page).to have_content('2019')
        expect(page).to have_content('Onix')
        expect(page).to have_content('Chevrolet')
        expect(page).to have_content('2020')
        expect(page).to have_content('Top', count: 2)
    end

    scenario 'and view details' do
        car_category = CarCategory.create!(name: 'Top', daily_rate: 200, car_insurance: 50,
                                           third_party_insurance: 20)
        CarModel.create!(name: 'KA', year: 2019, manufacturer: 'Ford', 
                         motorization:'1.0', car_category: car_category, fuel_type: 'Flex')
        CarModel.create!(name: 'Onix', year: 2020, manufacturer: 'Chevrolet', 
                         motorization:'1.0', car_category: car_category, fuel_type: 'Flex')

        visit root_path
        click_on 'Modelos de carro'
        click_on 'KA - 2019'

        expect(page).to have_content('KA')
        expect(page).to have_content('2019')
        expect(page).to have_content('Ford')
        expect(page).to have_content('1.0')
        expect(page).to have_content(car_category.name)
        expect(page).to have_content('Flex')
        expect(page).not_to have_content('Onix')
        expect(page).not_to have_content('Chevrolet')
    end

    scenario 'and no car model is registered' do
        visit root_path
        click_on 'Modelos de carro'
    
        expect(page).to have_content('Nenhum modelo de carro cadastrado')
    end
end