require 'rails_helper'

describe 'Usuário edita um estabelecimento' do
  it 'e não está logado' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)

    visit edit_establishment_path(establishment)
    
    expect(current_path).to eq new_user_owner_session_path
  end

  it 'está logado mas não é o dono' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    user_impostor = UserOwner.create!(name: 'Impostor', last_name: 'Zé', cpf: CPF.generate, email: 'impostor@email.com', password: 'password1234')

    login_as user_impostor
    visit edit_establishment_path(establishment)
    
    expect(current_path).to eq new_establishment_path
    expect(page).to have_content 'Você não possui acesso a este estabelecimento.'
  end

  it 'com sucesso' do
    user_owner = create_user_owner()
    Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'))

    login_as user_owner
    visit root_path
    click_on 'Restaurante'
    click_on 'editar'
    fill_in 'Nome Fantasia', with: 'Mc Donalds Jardins'
    click_on 'Salvar'

    expect(page).to have_content 'Estabelecimento atualizado com sucesso.'
    expect(page).to have_content 'Mc Donalds Jardins'
    expect(page).not_to have_content 'Fantasy'
  end
end