require 'rails_helper'

describe 'Usuário acessa rota de bebidas' do
  it 'sem estar autenticado' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', 
      cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    establ = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', 
      cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    bebida = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante de cola', establishment: establ)

    visit beverage_path(bebida)
    
    expect(current_path).to eq new_user_owner_session_path
  end

  it 'autenticado mas sem ser o dono' do
    impostor = UserOwner.create!(name: 'Impostor', last_name: 'Zé', 
      cpf: CPF.generate, email: 'impostor@email.com', password: 'password1234')
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', 
      cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    establ = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', 
      cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    bebida = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante de cola', establishment: establ)

    login_as impostor
    visit beverage_path(bebida)

    expect(current_path).to eq new_establishment_path
    expect(page).to have_content 'Você não possui acesso a esta bebida.'
  end

  it 'autenticado como o dono' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', 
      cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    establ = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', 
      cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    bebida = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante de cola', establishment: establ)

    login_as marcos
    visit beverage_path(bebida)

    expect(current_path).to eq beverage_path(bebida)
  end
end