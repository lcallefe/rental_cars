require 'rails_helper'
feature 'Admin edit subsidiary' do
  scenario 'and must be signed in' do
    subsidiary = Subsidiary.create!(name: 'Goias', cnpj: '12.877.998/3524-67', 
                                    address: 'Avenida Jabaquara')
                          
    visit edit_subsidiary_path(subsidiary)
    
    expect(current_path).to eq new_user_session_path
  end

  scenario 'sucessfully' do
    Subsidiary.create!(name: 'Goias', cnpj: '12.877.998/3524-67', address: 'Avenida Jabaquara')
    user_login()

    visit root_path
    click_on 'Filiais'
    click_on 'Goias'
    click_on 'Editar filial'
    fill_in 'Nome', with: 'Florianopolis'
    fill_in 'CNPJ', with: '55.486.353/5724-49'
    fill_in 'Endereço', with: 'Avenida BR-404'
    click_on 'Atualizar dados'

    expect(current_path).to eq subsidiaries_path 
    expect(page).to have_content('Florianopolis')
    expect(page).not_to have_content('Goias')
    expect(page).to have_link('Voltar')   
  end 
    
  scenario 'and view new details' do
    Subsidiary.create!(name: 'pernambuco', cnpj: '00.655.409/5091-70', address: 'Avenida Jabaquara')
    user_login()

    visit root_path
    click_on 'Filiais'
    click_on 'Pernambuco'
    click_on 'Editar filial'
    fill_in 'Nome', with: 'rio grande do sul'
    fill_in 'CNPJ', with: '50.544.507/3354-45'
    fill_in 'Endereço', with: 'avenida bosque da saúde'
    click_on 'Atualizar dados'
    click_on 'Rio Grande Do Sul'

    expect(page).to have_content('Rio Grande Do Sul')
    expect(page).to have_content('50.544.507/3354-45')
    expect(page).to have_content('Avenida Bosque Da Saúde')
    expect(page).not_to have_content('Pernambuco')
    expect(page).not_to have_content('00.655.409/5091-70')
  end
end