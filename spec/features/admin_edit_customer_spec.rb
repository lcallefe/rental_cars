require 'rails_helper'
feature 'Admin edit customer' do
  scenario 'and must be signed in' do
  
    visit root_path
    click_on 'Nossos clientes'
    
    expect(current_path).to eq new_user_session_path
  end

  scenario 'sucessfully' do
    Customer.create!(name: 'Maria', email: 'maria@gmail.com', 
                     document: '350.105.082-81')
    user_login()

    visit root_path
    click_on 'Nossos clientes'
    click_on 'Maria'
    click_on 'Editar usuário'
    fill_in 'Nome', with: 'Mario Pereira'
    fill_in 'Email', with: 'joaopereira@gmail.com'
    click_on 'Atualizar dados'

    expect(current_path).to eq customers_path 
    expect(page).to have_content('Mario Pereira')
    expect(page).not_to have_content('Maria')
    expect(page).to have_link('Voltar')
  end

  scenario 'and view new details' do
    Customer.create!(name: 'Bruno', email: 'bruno@gmail.com', 
                     document: '984.585.976-32')
    user_login()

    visit root_path
    click_on 'Nossos clientes'
    click_on 'Bruno'
    click_on 'Editar usuário'
    fill_in 'Nome', with: 'Gabriela Pereira'
    fill_in 'Email', with: 'gabrielapereira@gmail.com'
    fill_in 'CPF', with: '543.526.122-86'
    click_on 'Atualizar dados'
    click_on 'Gabriela Pereira'

    expect(page).to have_content('Gabriela Pereira')
    expect(page).to have_content('gabrielapereira@gmail.com')
    expect(page).to have_content('543.526.122-86')
    expect(page).not_to have_content('Bruno')
    expect(page).not_to have_content('bruno@gmail.com')
    expect(page).to have_link('Voltar')
  end
end