require 'rails_helper'

describe 'Usuário acessa rota do estabelecimento' do
  it 'sem estar autenticado' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)

    visit establishment_path(establishment)
    
    expect(current_path).to eq new_user_owner_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end
  
  it 'autenticado mas sem ser o dono' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    user_impostor = UserOwner.create!(name: 'Impostor', last_name: 'Zé', cpf: CPF.generate, email: 'impostor@email.com', password: 'password1234')

    login_as user_impostor
    visit establishment_path(establishment)
    
    expect(current_path).to eq new_establishment_path
    expect(page).to have_content 'Você não possui acesso a este estabelecimento.'
  end

  it 'autenticado como o dono' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)

    login_as user_owner
    visit establishment_path(establishment)
    
    expect(current_path).to eq establishment_path(establishment)
    expect(page).to have_content establishment.fantasy_name
  end
end
