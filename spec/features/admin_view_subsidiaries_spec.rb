require 'rails_helper'

feature 'Admin view all subsidiaries' do
  scenario 'and must be signed in' do
  
    visit root_path
    click_on 'Filiais'
    
    expect(current_path).to eq new_user_session_path
  end

  scenario 'successfully' do
    Subsidiary.create!(name: 'Tutoia', cnpj: '52.762.918/6965-32', address: 'Rua Tutoia, 1157')
    Subsidiary.create!(name: 'Hortolandia', cnpj: '63.156.429/0087-62', address: 'Rodovia Jornalista Francisco Aguirre')
    user_login()

    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Tutoia')
    expect(page).to have_content('Hortolandia')
  end

  scenario 'and view details' do
    Subsidiary.create!(name: 'Tutoia', cnpj: '66.376.597/7852-19', address: 'Rua Tutoia, 1157')
    Subsidiary.create!(name: 'Hortolandia', cnpj: '81.804.156/6509-20', address: 'Rodovia Jornalista Francisco Aguirre')
    user_login()

    visit root_path
    click_on 'Filiais'
    click_on 'Tutoia'

    expect(page).to have_content('Tutoia')
    expect(page).to have_content('Rua Tutoia, 1157')
    expect(page).to have_content('66.376.597/7852-19')
    expect(page).not_to have_content('Hortolandia')

  end 

  scenario 'and no subsidiaries are created' do
    user_login()

    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Nenhuma filial cadastrada')
  end

  scenario 'and return to subsidiaries page' do
    Subsidiary.create!(name: 'Hortolandia', cnpj: '41.986.504/8088-08', address: 'Rodovia Jornalista Francisco Aguirre')
    user_login()
    
    visit root_path
    click_on 'Filiais'
    click_on 'Hortolandia'
    click_on 'Voltar'

    expect(current_path).to eq subsidiaries_path
  end

  scenario 'and return to home page' do
    Subsidiary.create!(name: 'Hortolandia', cnpj: '34.982.441/9444-31', address: 'Rodovia Jornalista Francisco Aguirre')
    user_login()

    visit root_path
    click_on 'Filiais'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end