require 'rails_helper'

describe 'Usuário busca por itens' do
  it 'mas não está autenticado' do
    visit root_path

    expect(page).not_to have_field 'Buscar Item'
    expect(page).not_to have_button 'Buscar'
    expect(current_path).to eq new_user_owner_session_path
  end

  it 'e encontra um prato' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    fantasy = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    feijoada = Dish.create!(name: 'Feijoada', description: 'Feijão preto com carne', establishment: fantasy)

    login_as marcos
    visit root_path
    fill_in 'Buscar Item', with: feijoada.name
    click_on 'Buscar'
    
    expect(page).to have_content 'Resultado da Busca: 1 item encontrado'
    expect(page).to have_content 'Feijoada'
    expect(page).to have_content 'Editar'
  end

  it 'e vê detalhes de um prato' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    fantasy = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    feijoada = Dish.create!(name: 'Feijoada', description: 'Feijão preto com carne', establishment: fantasy)

    login_as marcos
    visit root_path
    fill_in 'Buscar Item', with: feijoada.name
    click_on 'Buscar'
    click_on 'Feijoada'
    
    expect(page).to have_content 'Feijão preto com carne'
  end

  it 'e edita um prato' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    fantasy = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    feijoada = Dish.create!(name: 'Feijoada', description: 'Feijão preto com carne', establishment: fantasy)

    login_as marcos
    visit root_path
    fill_in 'Buscar Item', with: feijoada.name
    click_on 'Buscar'
    click_on 'Editar'
    
    expect(page).to have_content 'Edite os campos que desejar'
  end

  it 'e encontra uma bebida' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    fantasy = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    coca = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante de cola', establishment: fantasy)

    login_as marcos
    visit root_path
    fill_in 'Buscar Item', with: coca.name
    click_on 'Buscar'
    
    expect(page).to have_content 'Resultado da Busca: 1 item encontrado'
    expect(page).to have_content 'Coca-Cola'
    expect(page).to have_content 'Editar'
  end

  it 'e vê detalhes de uma bebida' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    fantasy = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    coca = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante de cola', establishment: fantasy)

    login_as marcos
    visit root_path
    fill_in 'Buscar Item', with: coca.name
    click_on 'Buscar'
    click_on 'Coca-Cola'
    
    expect(page).to have_content 'Refrigerante de cola'
  end

  it 'e edita uma bebida' do
    marcos = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    fantasy = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: marcos, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    coca = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante de cola', establishment: fantasy)

    login_as marcos
    visit root_path
    fill_in 'Buscar Item', with: coca.name
    click_on 'Buscar'
    click_on 'Editar'
    
    expect(page).to have_content 'Edite os campos que desejar'
  end
end