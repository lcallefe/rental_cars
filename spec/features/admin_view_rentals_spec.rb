require 'rails_helper'

feature 'Admin view all rentals' do
  scenario 'and must be signed in to view list' do
    category = CarCategory.create!(name: 'categoria', car_insurance: 100, daily_rate: 100, 
                                   third_party_insurance: 200)
    customer = Customer.create!(name: 'Fulano', document: '425.076.618-79', 
                                email: 'fulano@gmail.com')
    user = User.create!(name: 'Usuario', email: 'user@user.com', password: '12345678')
    Rental.create!(start_date: Date.current, end_date: 2.days.from_now, user: user,
                   customer: customer, car_category: category )

    visit rentals_path
    
    expect(current_path).to eq new_user_session_path
  end

  scenario 'and must be signed in to view details' do
    category = CarCategory.create!(name: 'categoria', car_insurance: 100, daily_rate: 100, 
                                   third_party_insurance: 200)
    customer = Customer.create!(name: 'Fulano', document: '425.076.618-79', 
                                email: 'fulano@gmail.com')
    user = User.create!(name: 'Usuario', email: 'user@user.com', password: '12345678')
    rental = Rental.create!(start_date: Date.current, end_date: 2.days.from_now, user: user,
                            customer: customer, car_category: category )

    visit rental_path(rental)
    
    expect(current_path).to eq new_user_session_path
  end

  scenario 'sucessfully' do
    category = CarCategory.create!(name: 'Antigos', car_insurance: 100, daily_rate: 100, 
                                   third_party_insurance: 200)
    first_customer = Customer.create!(name: 'Fulano', document: '425.076.618-79', 
                                      email: 'fulano@gmail.com')
    sec_customer  =  Customer.create!(name: 'Sicrano', document: '774.181.678-06', 
                                      email: 'sicrano@gmail.com')
    user = User.create!(name: 'Usuario', email: 'user@user.com', password: '12345678')
    Rental.create!(start_date: Date.current, end_date: 2.days.from_now, user: user,
                   customer: first_customer, car_category: category )
    Rental.create!(start_date: Date.current, end_date: 2.days.from_now, user: user,
                   customer: sec_customer, car_category: category )

    user_login()
    visit root_path
    click_on 'Locações'
    
    expect(page).to have_content('Fulano')
    expect(page).to have_content('Sicrano')
    expect(page).to have_content('Usuario', count: 2)
    expect(page).to have_content('Antigos', count: 2)
  end

  scenario 'sucessfully' do
    category = CarCategory.create!(name: 'Carros Do Ano', car_insurance: 100, daily_rate: 100, 
                                   third_party_insurance: 200)
    first_customer = Customer.create!(name: 'Fulano', document: '425.076.618-79', 
                                      email: 'fulano@gmail.com')
    sec_customer  =  Customer.create!(name: 'Sicrano', document: '774.181.678-06', 
                                      email: 'sicrano@gmail.com')
    user = User.create!(name: 'Admin', email: 'user@user.com', password: '12345678')
    Rental.create!(start_date: Date.current, end_date: 2.days.from_now, user: user,
                   customer: first_customer, car_category: category )
    Rental.create!(start_date: Date.current, end_date: 2.days.from_now, user: user,
                   customer: sec_customer, car_category: category )

    user_login()
    visit root_path
    click_on 'Locações'
    
    expect(page).to have_content('Fulano')
    expect(page).to have_content('Sicrano')
    expect(page).to have_content('Admin', count: 2)
    expect(page).to have_content('Carros Do Ano', count: 2)
    expect(page).to have_content('Voltar')
  end
  scenario 'and view details' do
    category = CarCategory.create!(name: 'Carros Do Ano', car_insurance: 100, daily_rate: 100, 
                                   third_party_insurance: 100)
    first_customer = Customer.create!(name: 'Fulano', document: '425.076.618-79', 
                                      email: 'fulano@gmail.com')
    sec_customer  =  Customer.create!(name: 'Sicrano', document: '774.181.678-06', 
                                      email: 'sicrano@gmail.com')
    user = User.create!(name: 'Admin', email: 'user@user.com', password: '12345678')
    Rental.create!(start_date: '23/08/2020', end_date: '28/08/2020', user: user,
                   customer: first_customer, car_category: category )
    Rental.create!(start_date: '23/08/2030', end_date: '28/08/2030', user: user,
                   customer: sec_customer, car_category: category )

    user_login()
    visit root_path
    click_on 'Locações'
    click_on 'Sicrano'
    
    expect(page).to have_content('23/08/2030')
    expect(page).to have_content('28/08/2030')
    expect(page).to have_content('Sicrano')
    expect(page).to have_content('774.181.678-06')
    expect(page).to have_content('sicrano@gmail.com')
    expect(page).to have_content('Carros Do Ano')
    expect(page).to have_content('R$ 1.500,00')
    expect(page).not_to have_content('Fulano')
    expect(page).not_to have_content('23/08/2020')
    expect(page).not_to have_content('28/08/2020')
  end
  scenario 'and there is no rental scheduled' do
 
    user_login()
    visit root_path
    click_on 'Locações'
    
    expect(page).to have_content('Nenhuma locação realizada')
  end
end