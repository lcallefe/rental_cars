require 'rails_helper'

feature 'Admin schedule rental' do
  scenario 'and must be signed in' do
  
    visit new_rental_path
    
    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'sucessfully' do
    CarCategory.create!(name: 'categoria', car_insurance: 100, daily_rate: 100, 
                        third_party_insurance: 200)
    Customer.create!(name: 'Fulano', document: '425.076.618-79', email: 'fulano@gmail.com')
    
    user_login()
    visit root_path
    click_on 'Locações'
    click_on 'Agendar nova locação'
    fill_in 'Data de início', with: '21/08/2030'
    fill_in 'Data de término', with: '23/08/2030'
    select 'Fulano - 425.076.618-79', from: 'Cliente'
    select 'Categoria', from: 'Categoria de carro'
    click_on 'Agendar'

    expect(page).to have_content('21/08/2030')
    expect(page).to have_content('23/08/2030')
    expect(page).to have_content('Fulano')
    expect(page).to have_content('fulano@gmail.com')
    expect(page).to have_content('Categoria')
    expect(page).to have_content('R$ 800,00')
    expect(page).to have_content('Agendamento realizado com sucesso')
    end

  xscenario 'must fill all fields' do
    user_login()
    
    visit root_path
    click_on 'Locações'
    click_on 'Agendar nova locação'
    click_on 'Agendar'

    expect(page).to have_content('Data de início não pode ficar em branco')
    expect(page).to have_content('Data de término não pode ficar em branco')
    expect(page).to have_content('Cliente não pode ficar em branco')
    expect(page).to have_content('Categoria não pode ficar em branco')
  end

