require 'rails_helper'

describe 'Usuário cadastra um estabelecimento' do
  it 'e não está logado' do
    create_user_owner()

    visit new_establishment_path

    expect(current_path).to eq new_user_owner_session_path
  end

  it 'com sucesso' do
    user_owner = create_user_owner()

    login_as user_owner
    visit root_path
    fill_in 'Nome Fantasia', with: 'Fantasy'
    fill_in 'Razão Social', with: 'Irã Refeições LTDA'
    fill_in 'CNPJ', with: CNPJ.generate
    fill_in 'Endereço', with: 'Av Dulce Diniz, 18'
    fill_in 'Telefone', with: '079988887777'
    fill_in 'E-mail', with: 'fantasy@contato.com'
    check 'SEG'
    check 'TER'
    check 'SEX'
    fill_in 'Abre', with: '15:00'
    fill_in 'Fecha', with: '23:00'
    click_on 'Salvar'

    expect(page).to have_content 'Estabelecimento cadastrado com sucesso!'
    expect(page).to have_content 'Fantasy'
    expect(page).to have_content 'Av Dulce Diniz, 18'
    expect(page).to have_content 'fantasy@contato.com - 79988887777'
    expect(page).to have_content 'Segunda'
    expect(page).to have_content 'Terça'
    expect(page).to have_content 'Sexta'
    expect(page).to have_content 'Abre: 15:00 / Fecha: 23:00'
    expect(current_path).to eq establishment_path(Establishment.last)
  end

  it 'com os dados errados' do
    user_owner = create_user_owner()

    login_as user_owner
    visit root_path
    fill_in 'Razão Social', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Falha ao cadastrar estabelecimento!'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).not_to have_content 'Estabelecimento cadastrado com sucesso!'
  end
end
