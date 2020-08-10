require 'rails_helper'

feature 'Admin view all subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Tutoia', cnpj: '00000/0001', address: 'Rua Tutoia, 1157')
    Subsidiary.create!(name: 'Hortolandia', cnpj: '00000/6667', address: 'Rodovia Jornalista Francisco Aguirre')

    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Tutoia')
    expect(page).to have_content('Hortolandia')
  end

  scenario 'and view details' do
    Subsidiary.create!(name: 'Tutoia', cnpj: '00000/0001', address: 'Rua Tutoia, 1157')
    Subsidiary.create!(name: 'Hortolandia', cnpj: '00000/6667', address: 'Rodovia Jornalista Francisco Aguirre')
    visit root_path
    click_on 'Filiais'
    click_on 'Tutoia'

    expect(page).to have_content('Tutoia')
    expect(page).to have_content('Rua Tutoia, 1157')
    expect(page).to have_content('00000/0001')
    expect(page).not_to have_content('Hortolandia')

  end 

  scenario 'and no subsidiaries are created' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Nenhuma filial cadastrada')
  end

  scenario 'and return to subsidiaries page' do
    Subsidiary.create!(name: 'Hortolandia', cnpj: '00000/6667', address: 'Rodovia Jornalista Francisco Aguirre')
    
    visit root_path
    click_on 'Filiais'
    click_on 'Hortolandia'
    click_on 'Voltar'

    expect(current_path).to eq subsidiaries_path
  end

  scenario 'and return to home page' do
    Subsidiary.create!(name: 'Hortolandia', cnpj: '00000/6667', address: 'Rodovia Jornalista Francisco Aguirre')
    
    visit root_path
    click_on 'Filiais'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

    









end