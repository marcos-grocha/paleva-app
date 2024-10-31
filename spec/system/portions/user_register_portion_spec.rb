require 'rails_helper'

describe 'Usuário registra uma porção' do
  it 'através da página de detalhes de um prato' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', 
      cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    establ = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', 
      cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    prato = Dish.create!(name: 'Feijoada', description: 'Feijão preto com carne', establishment: establ, status: true)

    login_as marcos
    visit root_path
    click_on 'Pratos'
    click_on prato.name
    click_on 'Adicionar porção'
    fill_in 'Descrição', with: 'Porção pequena (350ml)'
    fill_in 'Preço', with: 18.00
    click_on 'Criar Porção'

    expect(page).to have_content 'Porção cadastrada com sucesso.'
    expect(page).to have_content 'Porção pequena (350ml)'
    expect(page).to have_content 'R$ 18,00'
  end

  it 'através da página de detalhes de uma bebida' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', 
      cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    establ = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', 
      cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    breja = Beverage.create!(name: 'Heineken', description: 'Cerveja Puro-Malte', establishment: establ, alcoholic: true)

    login_as marcos
    visit root_path
    click_on 'Bebidas'
    click_on breja.name
    click_on 'Adicionar porção'
    fill_in 'Descrição', with: 'Longneck (355ml)'
    fill_in 'Preço', with: 15.00
    click_on 'Criar Porção'

    expect(page).to have_content 'Porção cadastrada com sucesso.'
    expect(page).to have_content 'Longneck (355ml)'
    expect(page).to have_content 'R$ 15,00'
  end
end