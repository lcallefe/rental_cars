require 'rails_helper'

feature 'User sign in' do
  scenario 'from home page' do
    # Arrange
    # Act
    visit root_path

    expect(page).to have_link('Entrar')
  end

  scenario 'sucessfully' do
    # Arrange
    # Act
    
    visit root_page
    click_on 'Entrar'
    fill_in 'Email', with 'joao@gmail.com'
    fill_in 'Senha', with '12345678'
    click_on 'Entrar'

    expect(page).to have_content 'João Almeida'
    expect(page).to have_content 'Usuário cadastrado com sucesso'
    expect(page).to have_link 'Sair'
    expect(page).to have_link 'Entrar'
  end
end