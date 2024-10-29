require 'rails_helper'

describe 'Usuário clica em Bebidas' do
  it 'vai em detalhes e desabilita uma bebida' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', 
      cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    establ = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', 
      cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    bebida = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante de cola', establishment: establ)

    login_as marcos
    visit root_path
    click_on 'Bebidas'
    click_on bebida.name
    click_on 'Desativar'
    
    expect(page).to have_content 'Status da bebida atualizado com sucesso.'
    expect(page).to have_content 'Coca-Cola'
    expect(page).to have_content 'Refrigerante de cola'
    expect(page).to have_content 'Desativado'
    expect(page).not_to have_content 'Ativado'
  end
  
  it 'e vê bebida desabilitada' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', 
      cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    establ = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', 
      cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    bebida = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante de cola', establishment: establ, status: false)

    login_as marcos
    visit root_path
    click_on 'Bebidas'

    expect(page).to have_content bebida.name
    expect(page).to have_content 'Desativado'
  end
end