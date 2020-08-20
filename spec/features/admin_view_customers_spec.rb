require 'rails_helper'

feature 'Admin view all customers' do
  scenario 'successfully' do
    Customer.create!(name: 'João', document: CPF.generate(true), email: 'joão@gmail.com')
    Customer.create!(name: 'Maria', document: CPF.generate(true), email: 'maria@gmail.com')

    visit root_path
    click_on 'Nossos clientes'

    expect(page).to have_content('João')
    expect(page).to have_content('Maria')
  end

  scenario 'and view details' do
    Customer.create!(name: 'João', document: CPF.generate(true), email: 'joão@gmail.com')
    Customer.create!(name: 'Maria', document: CPF.generate(true), email: 'maria@gmail.com')

    visit root_path
    click_on 'Nossos clientes'
    click_on 'João'

    expect(page).to have_content('João')
    expect(page).to have_content('joão@gmail.com')
    expect(page).not_to have_content('Maria')
    expect(page).not_to have_content('maria@gmail.com')
  end 

  scenario 'and no customers are created' do
    visit root_path
    click_on 'Nossos clientes'

    expect(page).to have_content('Nenhum cliente cadastrado')
  end
end