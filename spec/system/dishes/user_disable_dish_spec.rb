require 'rails_helper'

describe 'Usuário clica em Pratos' do
  it 'vai em detalhes e desabilita um prato' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', 
      cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    establ = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', 
      cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    prato = Dish.create!(name: 'Feijoada', description: 'Feijão preto com carne', establishment: establ, status: true)

    login_as marcos
    visit root_path
    click_on 'Pratos'
    click_on prato.name
    click_on 'Desativar'
    
    expect(page).to have_content 'Status do prato atualizado com sucesso.'
    expect(page).to have_content 'Feijoada'
    expect(page).to have_content 'Feijão preto com carne'
    expect(page).to have_content 'Desativado'
    expect(page).not_to have_content 'Ativado'
  end

  it 'e vê prato desabilitado' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', 
      cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    establ = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', 
      cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    prato = Dish.create!(name: 'Feijoada', description: 'Feijão preto com carne', establishment: establ, status: false)

    login_as marcos
    visit root_path
    click_on 'Pratos'

    expect(page).to have_content prato.name
    expect(page).to have_content 'Desativado'
  end
end