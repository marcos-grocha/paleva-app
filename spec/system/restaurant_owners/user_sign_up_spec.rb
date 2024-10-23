require 'rails_helper'

describe 'Usuário cria uma conta (se auntentica)' do
  it 'como dono de um restaurante com sucesso' do
    

    visit root_path
    click_on 'Sign up'
    fill_in 'Nome', with: 'Marcos'
    fill_in 'Sobrenome', with: 'Guimaraes'
    fill_in 'CPF', with: CPF.generate
    fill_in 'Email', with: 'marcos@email.com'
    fill_in 'Senha', with: 'password1234'
    fill_in 'Confirme sua senha', with: 'password1234'
    click_on 'Sign up'

    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'Marcos'
    expect(page).to have_content '<marcos@email.com>'
    user = RestaurantOwner.last
    expect(user.name).to eq 'Marcos'
  end
end
