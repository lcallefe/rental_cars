require 'rails_helper'

feature 'Admin view all subsidiaries' do
  scenario 'successfully' do
    cnpj_tutoia = CNPJ.generate(true)
    cnpj_horto = CNPJ.generate(true)
    Subsidiary.create!(name: 'Tutoia', cnpj: cnpj_tutoia, address: 'Rua Tutoia, 1157')
    Subsidiary.create!(name: 'Hortolandia', cnpj: cnpj_horto, address: 'Rodovia Jornalista Francisco Aguirre')

    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Tutoia')
    expect(page).to have_content('Hortolandia')
  end

  scenario 'and view details' do
    cnpj_tutoia = CNPJ.generate(true)
    cnpj_horto = CNPJ.generate(true)
    Subsidiary.create!(name: 'Tutoia', cnpj: cnpj_tutoia, address: 'Rua Tutoia, 1157')
    Subsidiary.create!(name: 'Hortolandia', cnpj: cnpj_horto, address: 'Rodovia Jornalista Francisco Aguirre')

    visit root_path
    click_on 'Filiais'
    click_on 'Tutoia'

    expect(page).to have_content('Tutoia')
    expect(page).to have_content('Rua Tutoia, 1157')
    expect(page).to have_content(cnpj_tutoia)
    expect(page).not_to have_content('Hortolandia')

  end 

  scenario 'and no subsidiaries are created' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Nenhuma filial cadastrada')
  end

  scenario 'and return to subsidiaries page' do
    cnpj_horto = CNPJ.generate(true)
    Subsidiary.create!(name: 'Hortolandia', cnpj: cnpj_horto, address: 'Rodovia Jornalista Francisco Aguirre')
    
    visit root_path
    click_on 'Filiais'
    click_on 'Hortolandia'
    click_on 'Voltar'

    expect(current_path).to eq subsidiaries_path
  end

  scenario 'and return to home page' do
    cnpj_horto = CNPJ.generate(true)
    Subsidiary.create!(name: 'Hortolandia', cnpj: cnpj_horto, address: 'Rodovia Jornalista Francisco Aguirre')
    
    visit root_path
    click_on 'Filiais'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

    









end