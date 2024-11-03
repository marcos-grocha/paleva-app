require 'rails_helper'

describe 'Usuário acessa rota de bebidas' do
  it 'sem estar autenticado' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    beverage = create_beverage(establishment)

    visit beverage_path(beverage)
    
    expect(current_path).to eq new_user_owner_session_path
  end

  it 'autenticado mas sem ser o dono' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    beverage = create_beverage(establishment)
    user_impostor = UserOwner.create!(name: 'Impostor', last_name: 'Zé', cpf: CPF.generate, email: 'impostor@email.com', password: 'password1234')

    login_as user_impostor
    visit beverage_path(beverage)

    expect(current_path).to eq new_establishment_path
    expect(page).to have_content 'Você não possui acesso a esta bebida.'
  end

  it 'autenticado como o dono' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    beverage = create_beverage(establishment)

    login_as user_owner
    visit beverage_path(beverage)

    expect(current_path).to eq beverage_path(beverage)
  end
end