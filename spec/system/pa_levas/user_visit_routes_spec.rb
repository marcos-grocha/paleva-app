require 'rails_helper'

describe 'Usuário visita a rota raiz' do
  it 'e não está logado' do
    create_user_owner()
    
    visit root_path

    expect(current_path).to eq new_user_owner_session_path
  end

  it 'está logado mas não tem estabelecimento cadastrado' do
    create_user_owner()

    visit root_path
    fill_in 'E-mail', with: 'user@owner.com'
    fill_in 'Senha', with: 'password1234'
    click_on 'Log in'

    expect(current_path).to eq new_establishment_path
  end

  it 'está logado e tem estabelecimento cadastrado' do
    user_owner = create_user_owner()
    create_establishment(user_owner)

    visit root_path
    fill_in 'E-mail', with: 'user@owner.com'
    fill_in 'Senha', with: 'password1234'
    click_on 'Log in'

    expect(current_path).to eq menus_path
  end
end