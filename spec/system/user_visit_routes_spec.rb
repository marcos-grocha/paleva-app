require 'rails_helper'

describe 'Usuário visita a rota raiz' do
  it 'e não está autenticado' do
    visit root_path

    expect(current_path).to eq new_user_owner_session_path
  end

  it 'está autenticado mas não tem estabelecimento cadastrado' do
    UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    visit root_path
    fill_in 'E-mail', with: 'marcos@email.com'
    fill_in 'Senha', with: 'password1234'
    click_on 'Log in'

    expect(current_path).to eq new_establishment_path
  end

  it 'está autenticado e tem estabelecimento cadastrado' do
    user_owner = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    visit root_path
    fill_in 'E-mail', with: 'marcos@email.com'
    fill_in 'Senha', with: 'password1234'
    click_on 'Log in'

    expect(current_path).to eq establishment_path(Establishment.last)
  end
end