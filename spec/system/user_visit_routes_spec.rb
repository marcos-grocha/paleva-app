require 'rails_helper'

describe 'Usuário visita a rota raiz' do
  it 'e não está autenticado' do
    visit root_path

    expect(current_path).to eq new_user_owner_session_path
  end

  it 'está autenticado mas não tem estabelecimento cadastrado' do
    create_user()

    visit root_path
    fill_in 'E-mail', with: 'marcos@email.com'
    fill_in 'Senha', with: 'password1234'
    click_on 'Log in'

    expect(current_path).to eq new_establishment_path
  end

  it 'está autenticado e tem estabelecimento cadastrado' do
    user_owner = create_user()
    create_establishment(user_owner)

    visit root_path
    fill_in 'E-mail', with: 'marcos@email.com'
    fill_in 'Senha', with: 'password1234'
    click_on 'Log in'

    expect(current_path).to eq establishment_path(Establishment.last)
  end
end