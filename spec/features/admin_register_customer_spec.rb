require 'rails_helper'

feature 'Admin register customer' do
  scenario 'and must be signed in' do
  
    visit new_customer_path
    
    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'successfully' do
    user_login()

    visit root_path
    click_on 'Nossos clientes'
    click_on 'Cadastrar cliente'
    fill_in 'Nome', with: 'João S'
    fill_in 'Email', with: 'joaos@hotmail.com'
    fill_in 'CPF', with: '619.654.706-29'
    click_on 'Cadastrar cliente'

    expect(current_path).to eq customer_path(Customer.last)
    expect(page).to have_content('João S')
    expect(page).to have_content('joaos@hotmail.com')
    expect(page).to have_content('619.654.706-29')
    expect(page).to have_link('Voltar')
  end

  scenario 'and attributes cannot be blank' do
    user_login()

    visit root_path
    click_on 'Nossos clientes'
    click_on 'Cadastrar cliente'
    click_on 'Cadastrar cliente'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

  scenario 'CPF must be unique' do
    Customer.create!(name: 'João P', email: 'joaop@hotmail.com', document: '617.937.705-73')
    user_login()

    visit root_path
    click_on 'Nossos clientes'
    click_on 'Cadastrar cliente'
    fill_in 'Nome', with: 'Mario P'
    fill_in 'Email', with: 'mariop@gmail.com'
    fill_in 'CPF', with: '617.937.705-73'
    click_on 'Cadastrar cliente'

    expect(page).to have_content('CPF já está em uso')
  end

  scenario 'email must be unique' do
    Customer.create!(name: 'Helena', email: 'helena@hotmail.com', document: '109.874.804-21')
    user_login()

    visit root_path
    click_on 'Nossos clientes'
    click_on 'Cadastrar cliente'
    fill_in 'Nome', with: 'Helena Maria'
    fill_in 'Email', with: 'helena@hotmail.com'
    fill_in 'CPF', with: '691.358.467-98'
    click_on 'Cadastrar cliente'
    
    expect(page).to have_content('Email já está em uso')
  end
end