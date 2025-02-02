require 'rails_helper'

describe 'Usuário adiciona um marcador' do
  it 'com sucesso' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    Dish.create!(name: 'Feijoada', description: 'Descrição da feijoada', establishment: establishment)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    click_on 'Feijoada'
    click_on 'Adicionar Marcador'
    fill_in 'Nome do Marcador', with: 'Apimentado'
    click_on 'Salvar'

    expect(page).to have_content 'Marcador adicionado com sucesso.'
    expect(page).to have_content 'Prato Apimentado'
  end
end

describe 'Usuário vê um prato sem marcador' do
  it 'com sucesso' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    Dish.create!(name: 'Feijoada', description: 'Descrição da feijoada', establishment: establishment)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    click_on 'Feijoada'

    expect(page).to have_content 'Feijoada'
    expect(page).to have_content 'Descrição da feijoada'
    expect(page).to have_content 'Sem marcadores cadastrados'
  end
end
