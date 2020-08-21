require 'rails_helper'

feature 'Admin schedule rental' do
  scenario 'sucessfully' do
    CarCategory.create!(name: 'categoria', car_insurance: 100, daily_rate: 100, 
                        third_party_insurance: 200)
    Customer.create!(name: 'Fulano', document: '425.076.618-79', email: 'fulano@gmail.com')

    user = User.create!(name: 'Lorem Ipsum', email: 'lorem@hotmail.com',
                        password: '12345678')
    
    login_as user, scope: user
    visit root_path
    click_on 'Locações'
    click_on 'Agendar nova locação'
    fill_in 'Data de início', with: '21/08/2030'
    fill_in 'Data de término', with: '23/08/2030'
    select 'Fulano - 425.076.618-79', from: 'Cliente'
    select 'categoria', from: 'Categoria de carro'
    click_on 'Agendar'

    expect(page).to have_content('21/08/2030')
    expect(page).to have_content('23/08/2030')
    expect(page).to have_content('Fulano')
    expect(page).to have_content('fulano@gmail.com')
    expect(page).to have_content('categoria')
    expect(page).to have_content('R$ 600,00')
    expect(page).to have_content('Agendamento realizado com sucesso')
    end
  end

