require 'rails_helper'

describe 'Usuário adiciona uma característica' do
  it 'com sucesso' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    dish = create_dish(establishment)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    click_on dish.name
    click_on 'Adicionar Característica'
    fill_in 'Nome da Característica', with: 'Apimentado'
    click_on 'Salvar'

    expect(page).to have_content 'Característica adicionada com sucesso.'
    expect(page).to have_content 'Prato Apímentado'
  end
end
