require 'rails_helper'

describe 'Usuário acessa rota de bebidas' do
  it 'sem estar logado' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    beverage = create_beverage_refri(establishment)

    visit beverage_path(beverage)

    expect(current_path).to eq new_user_owner_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'logado mas sem ser o dono' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    beverage = create_beverage_refri(establishment)
    user_impostor = UserOwner.create!(name: 'Impostor', last_name: 'Zé', cpf: CPF.generate, email: 'impostor@email.com', password: 'password1234')

    login_as user_impostor
    visit beverage_path(beverage)

    expect(current_path).to eq new_establishment_path
    expect(page).to have_content 'Você não possui acesso a esta bebida.'
  end

  it 'logado como o dono' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    beverage = create_beverage_refri(establishment)

    login_as user_owner
    visit beverage_path(beverage)

    expect(current_path).to eq beverage_path(beverage)
  end
end
