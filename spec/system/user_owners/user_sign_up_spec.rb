require 'rails_helper'

describe 'Usuário cria uma conta de dono' do
  it 'com sucesso' do
    

    visit root_path
    click_on 'Sign up'
    fill_in 'Nome', with: 'Marcos'
    fill_in 'Sobrenome', with: 'Guimaraes'
    fill_in 'CPF', with: CPF.generate
    fill_in 'E-mail', with: 'marcos@email.com'
    fill_in 'Senha', with: 'password1234'
    fill_in 'Confirme sua senha', with: 'password1234'
    click_on 'Sign up'

    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'Marcos'
    expect(page).to have_content 'marcos@email.com'
    user_owner = UserOwner.last
    expect(user_owner.name).to eq 'Marcos'
  end

  it 'com os dados errados' do
    visit root_path
    click_on 'Sign up'
    fill_in 'Nome', with: ''
    fill_in 'Sobrenome', with: ''
    fill_in 'CPF', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: 'password1111'
    fill_in 'Confirme sua senha', with: 'password2222'
    click_on 'Sign up'

    expect(page).to have_content 'Não foi possível salvar dono de estabelecimento'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'sua senha não é igual'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Sobrenome não pode ficar em branco'
    expect(page).to have_content 'CPF não pode ficar em branco'
    expect(page).to have_content 'CPF inválido'
    expect(page).not_to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
  end
end
