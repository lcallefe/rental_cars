require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'and must be signed in' do
  
    visit new_subsidiary_path
    
    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'successfully' do
    user_login()
    
    visit root_path
    click_on 'Filiais'
    click_on 'Cadastrar nova filial'
    fill_in 'Nome', with: 'São Paulo'
    fill_in 'CNPJ', with: '48.383.144/2488-10'
    fill_in 'Endereço', with: 'Avenida São João, 567'
    click_on 'Criar filial'

    expect(current_path).to eq subsidiary_path(Subsidiary.last)
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('48.383.144/2488-10')
    expect(page).to have_content('Avenida São João, 567')
    expect(page).to have_link('Voltar')
  end
end


