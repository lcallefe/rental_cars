require 'rails_helper'

feature 'Admin view all customers' do
  scenario 'and must be signed in' do
  
    visit root_path
    click_on 'Nossos clientes'
    
    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'successfully' do
    Customer.create!(name: 'João', document: '975.909.546-75', email: 'joão@gmail.com')
    Customer.create!(name: 'Maria', document: '012.206.964-12', email: 'maria@gmail.com')
    user_login()

    visit root_path
    click_on 'Nossos clientes'

    expect(page).to have_content('João')
    expect(page).to have_content('Maria')
  end

  scenario 'and view details' do
    Customer.create!(name: 'João', document: '172.800.671-66', email: 'joão@gmail.com')
    Customer.create!(name: 'Maria', document: '558.375.075-82', email: 'maria@gmail.com')
    user_login()

    visit root_path
    click_on 'Nossos clientes'
    click_on 'João'

    expect(page).to have_content('João')
    expect(page).to have_content('joão@gmail.com')
    expect(page).not_to have_content('Maria')
    expect(page).not_to have_content('maria@gmail.com')
  end 

  scenario 'and no customers are created' do
    user_login()

    visit root_path
    click_on 'Nossos clientes'

    expect(page).to have_content('Nenhum cliente cadastrado')
  end
end