require 'rails_helper'

describe 'Usuário edita um prato' do
  it 'e não está logado' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    dish = Dish.create!(name: 'Feijoada', description: 'Descrição da feijoada', establishment: establishment)

    visit edit_dish_path(dish)
    
    expect(current_path).to eq new_user_owner_session_path
  end

  it 'está logado mas não é o dono' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    dish = create_dish_feijoada(establishment)
    user_impostor = UserOwner.create!(name: 'Impostor', last_name: 'Zé', cpf: CPF.generate, email: 'impostor@email.com', password: 'password1234')

    login_as user_impostor
    visit edit_dish_path(dish)

    expect(current_path).to eq new_establishment_path
    expect(page).to have_content 'Você não possui acesso a este prato.'
  end
  
  it 'com sucesso' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    Dish.create!(name: 'Feijoada', description: 'Descrição da feijoada', establishment: establishment)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    click_on 'Feijoada'
    click_on 'editar'
    fill_in 'Descrição', with: 'Editei a descrição'
    click_on 'Salvar'

    expect(page).to have_content 'Prato atualizado com sucesso.'
    expect(page).to have_content 'Feijoada'
    expect(page).to have_content 'Editei a descrição'
    expect(page).not_to have_content 'Descrição da feijoada'
  end
end
