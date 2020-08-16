require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully' do
    cnpj = CNPJ.generate(true)

    visit root_path
    click_on 'Filiais'
    click_on 'Cadastrar nova filial'
    fill_in 'Nome', with: 'São Paulo'
    fill_in 'CNPJ', with: cnpj
    fill_in 'Endereço', with: 'Rua 10'
    click_on 'Criar filial'

    expect(current_path).to eq subsidiary_path(Subsidiary.last)
    expect(page).to have_content('São Paulo')
    expect(page).to have_content(cnpj)
    expect(page).to have_content('Rua 10')
    expect(page).to have_link('Voltar')
  end

  scenario 'and edit details' do
    cnpj_sc = CNPJ.generate(true)
    cnpj_pe = CNPJ.generate(true)

    visit root_path
    click_on 'Filiais'
    click_on 'Cadastrar nova filial'
    fill_in 'Nome', with: 'Florianopolis'
    fill_in 'CNPJ', with: cnpj_sc
    fill_in 'Endereço', with: 'Rua 20'
    click_on 'Criar filial'
    click_on 'Editar filial'
    fill_in 'Nome', with: 'Pernambuco'
    fill_in 'CNPJ', with: cnpj_pe
    fill_in 'Endereço', with: 'Rua dos bobos'
    click_on 'Atualizar dados'

    expect(current_path).to eq subsidiaries_path 
    expect(page).to have_content('Pernambuco')
    expect(page).not_to have_content('Florianopolis')
    expect(page).to have_link('Voltar')
  end
end


