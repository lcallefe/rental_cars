require 'rails_helper'

feature 'Admin register valid subsidiary' do
  scenario 'and must be signed in' do
  
    visit new_subsidiary_path
    
    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'and name must be unique' do
    Subsidiary.create!(name: 'Sergipe', cnpj: '01.077.297/0001-56', 
                       address: 'Rua Dr Nogueira Martins, 680')
    user_login()                   

    visit root_path
    click_on 'Filiais'
    click_on 'Cadastrar nova filial'
    fill_in 'Nome', with: 'Sergipe'
    fill_in 'CNPJ', with: '30.449.114/0001-84'
    fill_in 'Endereço', with: 'Rua Caramuru, 76'
    click_on 'Criar filial'

    expect(page).to have_content('já está em uso')
  end

  scenario 'and CNPJ must be unique' do
    Subsidiary.create!(name: 'Mato Grosso do Sul', cnpj: '57.944.942/0001-45', 
                       address: 'Av. Jabaquara, 680')
    user_login()

    visit root_path
    click_on 'Filiais'
    click_on 'Cadastrar nova filial'
    fill_in 'Nome', with: 'Mato Grosso'
    fill_in 'CNPJ', with: '57.944.942/0001-45'
    fill_in 'Endereço', with: 'Av. Jabaquara, 680'
    click_on 'Criar filial'

    expect(page).to have_content('já está em uso')
  end

  scenario 'and attributes cannot be blank' do
    user_login()

    visit root_path
    click_on 'Filiais'
    click_on 'Cadastrar nova filial'
    click_on 'Criar filial'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end
end
