require 'rails_helper'

feature 'Admin edit car car_category' do
  scenario 'and must be signed in' do
    
    visit root_path
    click_on 'Categorias'
    
    expect(current_path).to eq new_user_session_path
  end

  scenario 'sucessfully' do
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    user_login()
    
    visit root_path
    click_on 'Categorias'
    click_on 'Top'
    click_on 'Editar categoria'
    fill_in 'Nome', with: 'Master'
    fill_in 'Diária', with: '100'
    fill_in 'Seguro do carro', with: '50'
    fill_in 'Seguro para terceiros', with: '10'
    click_on 'Atualizar dados'

    expect(current_path).to eq car_categories_path 
    expect(page).to have_content('Master')
    expect(page).not_to have_content('Top')
    expect(page).to have_link('Voltar')
  end

  scenario 'and view new details' do
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)
    user_login()
    
    visit root_path
    click_on 'Categorias'
    click_on 'Top'
    click_on 'Editar categoria'
    fill_in 'Nome', with: 'Super'
    fill_in 'Diária', with: '100'
    fill_in 'Seguro do carro', with: '50'
    fill_in 'Seguro para terceiros', with: '10'
    click_on 'Atualizar dados'
    click_on 'Super'

    expect(page).to have_content('Super')
    expect(page).to have_content('R$ 100,00')
    expect(page).to have_content('R$ 50,00')
    expect(page).to have_content('R$ 10,00')  
    expect(page).to have_link('Voltar')
  end
end

  