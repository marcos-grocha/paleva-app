require 'rails_helper'

describe 'Usuário autenticado cadastra um restaurante' do
  it 'com sucesso' do
    user = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    
    login_as user
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
    click_on 'Cadastrar estabelecimento'
    
    expect(page).to have_content 'Estabelecimento cadastrado com sucesso!'
    expect(page).to have_content 'Nome: Fantasy'
    expect(page).to have_content 'Endereço: Av Dulce Diniz, 18'
    expect(page).to have_content 'Contato: fantasy@contato.com | 79988887777'
  end
end
