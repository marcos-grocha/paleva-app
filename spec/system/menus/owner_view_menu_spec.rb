require 'rails_helper'

describe 'Dono acessa rota de menus' do
  it 'sem estar logado' do
    user_owner = create_user_owner()
    menu = create_menu(user_owner)

    visit menu_path(menu)
    
    expect(current_path).to eq pa_leva_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'está logado mas não tem vínculo' do
    user_owner = create_user_owner()
    menu = create_menu(user_owner)
    user_impostor = UserOwner.create!(name: 'Impostor', last_name: 'Zé', cpf: CPF.generate, email: 'impostor@email.com', password: 'password1234')

    login_as user_impostor
    visit menu_path(menu)

    # expect(current_path).to eq new_establishment_path
    # expect(current_path).not_to eq menu_path(menu)
    expect(page).to have_content 'Você não possui acesso a este menu.'
  end

  it 'e está logado' do
    user_owner = create_user_owner()
    menu = create_menu(user_owner)
    
    login_as user_owner
    visit menu_path(menu)

    expect(current_path).to eq menu_path(menu)
  end
end