require 'rails_helper'

describe 'Usuário acessa listagem de pratos' do
  it 'e vê em detalhes de um prato' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', 
      cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    establ = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', 
      cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    prato = Dish.create!(name: 'Feijoada', description: 'Feijão preto com carne', establishment: establ)

    login_as marcos
    visit root_path
    click_on 'Pratos'
    click_on 'Feijoada'

    expect(page).to have_content 'Feijoada'
    expect(page).to have_content 'Feijão preto com carne'
    expect(current_path).to eq dish_path(prato)
  end

  it 'e escolhe por listar apenas pratos apimentados' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', 
      cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    establ = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', 
      cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    feijoada = Dish.create!(name: 'Feijoada', description: 'Feijão preto com carne', establishment: establ, spicy: true)
    arroz = Dish.create!(name: 'Arroz', description: 'Arroz branco com cebola', establishment: establ, gluten_free: true)

    login_as marcos
    visit root_path
    click_on 'Pratos'
    click_on 'Apimentados'

    expect(page).to have_content feijoada.name
    expect(page).not_to have_content arroz.name
  end

  it 'e escolhe por listar apenas pratos sem glutén' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', 
      cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    establ = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', 
      cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    feijoada = Dish.create!(name: 'Feijoada', description: 'Feijão preto com carne', establishment: establ, spicy: true)
    arroz = Dish.create!(name: 'Arroz', description: 'Arroz branco com cebola', establishment: establ, gluten_free: true)

    login_as marcos
    visit root_path
    click_on 'Pratos'
    click_on 'Sem Glúten'

    expect(page).to have_content arroz.name
    expect(page).not_to have_content feijoada.name
  end
end