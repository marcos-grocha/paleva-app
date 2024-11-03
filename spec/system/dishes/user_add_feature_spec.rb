require 'rails_helper'

describe 'Usuário adiciona um marcador' do
  it 'com sucesso' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    dish = create_dish(establishment)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    click_on dish.name
    click_on 'Adicionar Marcador'
    fill_in 'Nome do Marcador', with: 'Apimentado'
    click_on 'Salvar'

    expect(page).to have_content 'Marcador adicionado com sucesso.'
    expect(page).to have_content 'Prato Apimentado'
  end
end
