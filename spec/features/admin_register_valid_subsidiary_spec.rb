require 'rails_helper'

feature 'Admin register valid subsidiary' do
  scenario 'and name must be unique' do
    Subsidiary.create!(name: 'Sergipe', cnpj: '01.077.297/0001-56', 
                       address: 'Rua Dr Nogueira Martins, 680')

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
    Subsidiary.create!(name: 'MS', cnpj: '57.944.942/0001-45', 
                       address: 'Av. Jabaquara, 680')

    visit root_path
    click_on 'Filiais'
    click_on 'Cadastrar nova filial'
    fill_in 'Nome', with: 'MT'
    fill_in 'CNPJ', with: '57.944.942/0001-45'
    fill_in 'Endereço', with: 'Av. Jabaquara, 680'
    click_on 'Criar filial'

    expect(page).to have_content('já está em uso')
  end

  scenario 'and attributes cannot be blank' do
    visit root_path
    click_on 'Filiais'
    click_on 'Cadastrar nova filial'
    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Criar filial'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end
end
