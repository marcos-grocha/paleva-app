require 'rails_helper'

describe 'Dono faz login' do
  it 'com sucesso' do
    UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')

    visit root_path
    click_on 'Administrador'
    fill_in 'E-mail', with: 'marcos@email.com'
    fill_in 'Senha', with: 'password1234'
    click_on 'Entrar'

    expect(page).to have_content 'Login efetuado com sucesso.'
    expect(page).to have_button 'Sair'
  end

  it 'com os dados errados' do
    UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')

    visit root_path
    click_on 'Administrador'
    fill_in 'E-mail', with: 'joao@email.com'
    fill_in 'Senha', with: 'password5555'
    click_on 'Entrar'

    expect(page).to have_content 'E-mail ou senha inválidos.'
    expect(page).not_to have_button 'Sair'
  end
end
