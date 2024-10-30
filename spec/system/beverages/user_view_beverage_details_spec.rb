require 'rails_helper'

describe 'Usuário acessa listagem de bebidas' do
  it 'e vê em detalhes de uma bebida' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', 
      cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    establ = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', 
      cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    bebida = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante de cola', establishment: establ)

    login_as marcos
    visit root_path
    click_on 'Bebidas'
    click_on 'Coca-Cola'

    expect(page).to have_content 'Coca-Cola'
    expect(page).to have_content 'Refrigerante de cola'
    expect(page).to have_content 'Não Alcoolica'
    expect(current_path).to eq beverage_path(bebida)
  end

  it 'e escolhe por listar apenas bebidas alcoólicas' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', 
      cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    establ = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', 
      cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    refri = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante de cola', establishment: establ, alcoholic: false)
    breja = Beverage.create!(name: 'Heineken', description: 'Cerveja Puro-Malte', establishment: establ, alcoholic: true)

    login_as marcos
    visit root_path
    click_on 'Bebidas'
    click_on 'Alcoólicas'

    expect(page).to have_content breja.name
    expect(page).not_to have_content refri.name
  end

  it 'e escolhe por listar apenas bebidas sem alcoól' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', 
      cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    establ = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', 
      cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    refri = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante de cola', establishment: establ, alcoholic: false)
    breja = Beverage.create!(name: 'Heineken', description: 'Cerveja Puro-Malte', establishment: establ, alcoholic: true)

    login_as marcos
    visit root_path
    click_on 'Bebidas'
    click_on 'Não Alcoólicas'

    expect(page).to have_content refri.name
    expect(page).not_to have_content breja.name
  end
end