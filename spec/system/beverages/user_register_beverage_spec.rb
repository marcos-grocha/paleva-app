require 'rails_helper'

describe 'Usuário cadastra uma bebida' do
  it 'com sucesso' do
    u = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: u, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    
    login_as u
    visit root_path
    click_on 'Bebidas'
    click_on 'Cadastrar Bebida'
    fill_in 'Nome', with: 'Coca-Cola'
    fill_in 'Descrição', with: 'Refrigerante de Cola'
    click_on 'Salvar'
    
    expect(page).to have_content 'Bebida cadastrada com sucesso!'
    expect(page).to have_content 'Bebidas Disponíveis'
    expect(page).to have_content 'Coca-Cola'
  end
end