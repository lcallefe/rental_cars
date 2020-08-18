feature 'Admin register subsidiary' do
  scenario 'successfully' do
    cpf = CPF.generate(true)

    visit root_path
    click_on 'Nossos clientes'
    click_on 'Cadastrar cliente'
    fill_in 'Nome', with: 'João S'
    fill_in 'Email', with: 'joaos@hotmail.com'
    fill_in 'CPF', with: cpf
    click_on 'Cadastrar'

    expect(current_path).to eq customer_path(Customer.last)
    expect(page).to have_content('João S')
    expect(page).to have_content('joaos@hotmail.com')
    expect(page).to have_content(cpf)
    expect(page).to have_link('Voltar')
  end

  scenario 'and edit details' do
    cpf = CPF.generate(true)
   
    visit root_path
    click_on 'Nossos clientes'
    click_on 'Cadastrar cliente'
    fill_in 'Nome', with: 'João P'
    fill_in 'Email', with: 'joaop@hotmail.com'
    fill_in 'CPF', with: cpf
    click_on 'Cadastrar'
    click_on 'Editar usuário'
    fill_in 'Nome', with: 'Mario Pereira'
    fill_in 'Email', with: 'joaopereira@gmail.com'
    click_on 'Atualizar dados'

    expect(current_path).to eq customers_path 
    expect(page).to have_content('Mario Pereira')
    expect(page).to have_content('joaopereira@hotmail.com')
    expect(page).not_to have_content('João P')
    expect(page).not_to have_content('joaop@hotmail.com')
    expect(page).to have_link('Voltar para a home page')
  end