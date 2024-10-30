require 'rails_helper'

describe 'Usuário cadastra um prato' do
  it 'com sucesso' do
    u = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: u, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    
    login_as u
    visit root_path
    click_on 'Pratos'
    click_on 'Cadastrar Prato'
    fill_in 'Nome', with: 'Feijoada'
    fill_in 'Descrição', with: 'Feijão preto com carne'
    fill_in 'Calorias', with: ''
    attach_file 'Foto do Prato', Rails.root.join('spec', 'support', 'feijoada.jpg')
    click_on 'Salvar'

    expect(page).to have_content 'Prato cadastrado com sucesso!'
    expect(page).to have_content 'Pratos Disponíveis'
    expect(page).to have_content 'Feijoada'
  end

  it 'vegetariano, vegano e sem glútem com sucesso e vê detalhes' do
    u = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: u, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    
    login_as u
    visit root_path
    click_on 'Pratos'
    click_on 'Cadastrar Prato'
    fill_in 'Nome', with: 'Feijoada'
    fill_in 'Descrição', with: 'Feijão preto com carne'
    fill_in 'Calorias', with: ''
    check 'Vegetariano'
    check 'Vegano'
    check 'Sem Glúten'
    attach_file 'Foto do Prato', Rails.root.join('spec', 'support', 'feijoada.jpg')
    click_on 'Salvar'
    click_on 'Feijoada'

    expect(page).to have_content 'Feijoada'
    expect(page).to have_content 'Prato Vegetariano'
    expect(page).to have_content 'Prato Vegano'
    expect(page).to have_content 'Prato Sem Glúten'
    expect(page).to have_css("img[src*='feijoada.jpg']")
  end

  it 'sem glútem, sem açucar e apimentado com sucesso e vê detalhes' do
    u = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: u, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    
    login_as u
    visit root_path
    click_on 'Pratos'
    click_on 'Cadastrar Prato'
    fill_in 'Nome', with: 'Feijoada'
    fill_in 'Descrição', with: 'Feijão preto com carne'
    fill_in 'Calorias', with: ''
    check 'Sem Glúten'
    check 'Sem Açúcar'
    check 'Apimentado'
    attach_file 'Foto do Prato', Rails.root.join('spec', 'support', 'feijoada.jpg')
    click_on 'Salvar'
    click_on 'Feijoada'

    expect(page).to have_content 'Feijoada'
    expect(page).to have_content 'Prato Sem Glúten'
    expect(page).to have_content 'Prato Sem Açúcar'
    expect(page).to have_content 'Prato Apimentado'
    expect(page).to have_css("img[src*='feijoada.jpg']")
  end
end