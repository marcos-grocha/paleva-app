require 'rails_helper'

describe 'Dono visita a rota raiz' do
  it 'e não está logado' do
    UserOwner.create!(name: 'User', last_name: 'Owner', cpf: CPF.generate, email: 'user@owner.com', password: 'password1234')
    
    visit root_path

    expect(current_path).to eq pa_leva_session_path
  end

  it 'está logado mas não tem estabelecimento cadastrado' do
    UserOwner.create!(name: 'User', last_name: 'Owner', cpf: CPF.generate, email: 'user@owner.com', password: 'password1234')

    visit root_path
    click_on 'Dono de Estabelecimento'
    fill_in 'E-mail', with: 'user@owner.com'
    fill_in 'Senha', with: 'password1234'
    click_on 'Log in'

    expect(current_path).to eq new_establishment_path
  end

  it 'está logado e tem estabelecimento cadastrado' do
    user_owner = UserOwner.create!(name: 'User', last_name: 'Owner', cpf: CPF.generate, email: 'user@owner.com', password: 'password1234')
    Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('12:00'), closing_time: Time.parse('15:00'))

    visit root_path
    click_on 'Dono de Estabelecimento'
    fill_in 'E-mail', with: 'user@owner.com'
    fill_in 'Senha', with: 'password1234'
    click_on 'Log in'

    expect(current_path).to eq menus_path
  end
end