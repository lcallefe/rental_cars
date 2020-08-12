require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully' do
    visit root_path
    click_on 'Filiais'
    click_on 'Cadastrar nova filial'
    fill_in 'Nome', with: 'São Paulo'
    fill_in 'CNPJ', with: '12345/001'
    fill_in 'Endereço', with: 'Rua 10'
    click_on 'Enviar'

    expect(current_path).to eq subsidiary_path(Subsidiary.last)
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('12345/001')
    expect(page).to have_content('Rua 10')
    expect(page).to have_link('Voltar')
  end

  scenario 'and edit details' do
    visit root_path
    click_on 'Filiais'
    click_on 'Cadastrar nova filial'
    fill_in 'Nome', with: 'Florianopolis'
    fill_in 'CNPJ', with: '12345/0002'
    fill_in 'Endereço', with: 'Rua 20'
    click_on 'Enviar'
    click_on 'Editar filial'
    fill_in 'Nome', with: 'Pernambuco'
    fill_in 'CNPJ', with: '12345/6667'
    fill_in 'Endereço', with: 'Rua dos bobos'
    click_on 'Atualizar dados'

    expect(current_path).to eq subsidiaries_path 
    expect(page).to have_content('Pernambuco')
    expect(page).not_to have_content('Florianopolis')
    expect(page).to have_link('Voltar')
  end
end


