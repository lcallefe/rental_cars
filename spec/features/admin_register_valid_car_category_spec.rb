require 'rails_helper'

feature 'Admin register valid car category' do
  scenario 'and must be signed in' do
  
    visit root_path
    click_on 'Categorias'
    
    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'and name must be unique' do
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    user_login()                    

    visit root_path
    click_on 'Categorias'
    click_on 'Registrar uma nova categoria'
    fill_in 'Nome', with: 'Top'
    fill_in 'Diária', with: '100'
    fill_in 'Seguro do carro', with: '50'
    fill_in 'Seguro para terceiros', with: '10'
    click_on 'Criar categoria'

    expect(page).to have_content('já está em uso')
  end

  scenario 'and attributes cannot be blank' do
    user_login()

    visit root_path
    click_on 'Categorias'
    click_on 'Registrar uma nova categoria'
    click_on 'Criar categoria'

    expect(page).to have_content('não pode ficar em branco', count: 4)
  end
end
