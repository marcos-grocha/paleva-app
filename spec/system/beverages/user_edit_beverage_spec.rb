require 'rails_helper'

describe 'Usuário edita uma bebida' do
  it 'e não está logado' do
    user_owner = create_user_owner()
    estab = create_establishment(user_owner)
    beverage = Beverage.create!(name: 'Heineken', description: 'Descrição da cerveja', establishment: estab)

    visit edit_beverage_path(beverage)
    
    expect(current_path).to eq new_user_owner_session_path
  end

  it 'está logado mas não é o dono' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    beverage = create_beverage_refri(establishment)
    user_impostor = UserOwner.create!(name: 'Impostor', last_name: 'Zé', cpf: CPF.generate, email: 'impostor@email.com', password: 'password1234')

    login_as user_impostor
    visit edit_beverage_path(beverage)

    expect(current_path).to eq new_establishment_path
    expect(page).to have_content 'Você não possui acesso a esta bebida.'
  end

  it 'com sucesso' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    Beverage.create!(name: 'Heineken', description: 'Descrição da cerveja', establishment: establishment)

    login_as user_owner
    visit root_path
    click_on 'Bebidas'
    click_on 'Heineken'
    click_on 'editar'
    fill_in 'Descrição', with: 'Editei a descrição'
    click_on 'Salvar'

    expect(page).to have_content 'Bebida atualizado com sucesso.'
    expect(page).to have_content 'Heineken'
    expect(page).to have_content 'Editei a descrição'
    expect(page).not_to have_content 'Descrição da cerveja'
  end  
end
