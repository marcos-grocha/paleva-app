require 'rails_helper'

describe 'Usuário vê o histórico de uma porção' do
  it 'através da página de detalhes de um prato' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', 
      cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    establ = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', 
      cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    prato = Dish.create!(name: 'Feijoada', description: 'Feijão preto com carne', establishment: establ, status: true)
    porcao = Portion.create!(description: 'Porção Pequena Feijoada', price: '22.00', dish: prato)
    porcao.update!(price: 25.0)

    login_as marcos
    visit root_path
    click_on 'Pratos'
    click_on prato.name
    click_on 'Histórico'

    expect(page).to have_content 'Detalhes da Porção'
    expect(page).to have_content 'Histórico de Alterações'
    expect(page).to have_content 'Porção Pequena Feijoada'
    expect(page).to have_content 'R$ 25.0'
  end

  it 'através da página de detalhes de uma bebida' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', 
      cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    establ = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', 
      cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    breja = Beverage.create!(name: 'Heineken', description: 'Cerveja Puro-Malte', establishment: establ, alcoholic: true)
    porcao = Portion.create!(description: 'Porção Pequena Heineken', price: '12.00', beverage: breja)
    porcao.update!(price: 15.0)

    login_as marcos
    visit root_path
    click_on 'Bebidas'
    click_on breja.name
    click_on 'Histórico'

    expect(page).to have_content 'Detalhes da Porção'
    expect(page).to have_content 'Porção Pequena Heineken'
    expect(page).to have_content 'R$ 15.0'
  end
end