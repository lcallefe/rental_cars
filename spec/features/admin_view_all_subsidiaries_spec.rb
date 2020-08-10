require 'rails_helper'

feature 'Admin view all subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Tutoia', CNPJ: '00000/0001', address: 'Rua Tutoia, 1057')
   

    visit root_path
    click_on 'Subsidiary'

    expect(page).to have_content('Tutoia')
  end
end