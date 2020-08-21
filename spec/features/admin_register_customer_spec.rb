require 'rails_helper'

feature 'Admin register customer' do
  scenario 'successfully' do
    cpf = CPF.generate(true)

    visit root_path
    click_on 'Nossos clientes'
    click_on 'Cadastrar cliente'
    fill_in 'Nome', with: 'João S'
    fill_in 'Email', with: 'joaos@hotmail.com'
    fill_in 'CPF', with: cpf
    click_on 'Cadastrar cliente'

    expect(current_path).to eq customer_path(Customer.last)
    expect(page).to have_content('João S')
    expect(page).to have_content('joaos@hotmail.com')
    expect(page).to have_content(cpf)
    expect(page).to have_link('Voltar')
  end

  scenario 'and attributes cannot be blank' do
    visit root_path
    click_on 'Nossos clientes'
    click_on 'Cadastrar cliente'
    click_on 'Cadastrar cliente'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

  scenario 'edit details' do
    cpf = CPF.generate(true)
   
    visit root_path
    click_on 'Nossos clientes'
    click_on 'Cadastrar cliente'
    fill_in 'Nome', with: 'João P'
    fill_in 'Email', with: 'joaop@hotmail.com'
    fill_in 'CPF', with: cpf
    click_on 'Cadastrar cliente'
    click_on 'Editar usuário'
    fill_in 'Nome', with: 'Mario Pereira'
    fill_in 'Email', with: 'joaopereira@gmail.com'
    click_on 'Atualizar dados'

    expect(current_path).to eq customers_path 
    expect(page).to have_content('Mario Pereira')
    expect(page).not_to have_content('João P')
    expect(page).to have_link('Voltar')
  end

  scenario 'CPF must be unique' do
    cpf = CPF.generate(true)
  

    visit root_path
    click_on 'Nossos clientes'
    click_on 'Cadastrar cliente'
    fill_in 'Nome', with: 'João P'
    fill_in 'Email', with: 'joaop@hotmail.com'
    fill_in 'CPF', with: cpf
    click_on 'Cadastrar cliente'
    click_on 'Voltar'
    click_on 'Cadastrar cliente'
    fill_in 'Nome', with: 'Mario Pereira'
    fill_in 'Email', with: 'joaopereira@gmail.com'
    fill_in 'CPF', with: cpf
    click_on 'Cadastrar cliente'

    expect(page).to have_content('CPF já está em uso')
  end

  scenario 'email must be unique' do
    visit root_path
    click_on 'Nossos clientes'
    click_on 'Cadastrar cliente'
    fill_in 'Nome', with: 'João P'
    fill_in 'Email', with: 'lucianacallefe95@hotmail.com'
    fill_in 'CPF', with: CPF.generate(true)
    click_on 'Cadastrar cliente'
    click_on 'Voltar'
    click_on 'Cadastrar cliente'
    fill_in 'Nome', with: 'Mario Pereira'
    fill_in 'Email', with: 'lucianacallefe95@hotmail.com'
    fill_in 'CPF', with: CPF.generate(true)
    click_on 'Cadastrar cliente'

    expect(page).to have_content('Email já está em uso')
  end
end