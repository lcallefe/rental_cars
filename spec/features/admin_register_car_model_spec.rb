require 'rails_helper'

feature 'Admin register car model' do
  scenario 'sucessfully' do
    CarCategory.create!(name: 'Top', daily_rate: 100, car_insurance: 50,
                        third_party_insurance: 50)

    visit root_path
    click_on 'Modelos de carro'
    click_on 'Registrar um modelo de carro'
    fill_in 'Nome', with: 'Kadett'
    fill_in 'Ano', with: '1994'
    fill_in 'Fabricante', with: 'Chevrolet'
    fill_in 'Motorização', with: '1.6'
    select 'Top', from: 'Categoria de carro'
    fill_in 'Tipo de combustível', with: 'Gasolina'
    click_on 'Enviar'

    expect(page).to have_content('Kadett')
    expect(page).to have_content('1994')
    expect(page).to have_content('Chevrolet')
    expect(page).to have_content('1.6')
    expect(page).to have_content('Top')
    expect(page).to have_content('Gasolina')
  end

  scenario 'must fill in all fields' do
    visit root_path
    click_on 'Modelos de carro'
    click_on 'Registrar um modelo de carro'
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Fabricante não pode ficar em branco')
    expect(page).to have_content('Tipo de combustível não pode ficar em branco')
    expect(page).to have_content('Motorização não pode ficar em branco')
    expect(page).to have_content('Ano não pode ficar em branco')
    expect(page).to have_content('Categoria de carro não pode ficar em branco')
    expect(page).to have_content('Escolha uma categoria de carro')
  end
end

    