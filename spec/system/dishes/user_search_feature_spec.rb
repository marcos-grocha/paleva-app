require 'rails_helper'

describe 'Usuário procura por um marcador' do
  it 'e encontra pratos apimentados' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    feijoada = Dish.create!(name: 'Feijoada', description: 'Descrição da feijoada', establishment: establishment)
    AdditionalFeature.create!(name: 'Apimentado', active: true, dish: feijoada)
    arroz = Dish.create!(name: 'Arroz', description: 'Descrição do arroz', establishment: establishment)
    AdditionalFeature.create!(name: 'Vegano', active: true, dish: arroz)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    fill_in 'Digite um Marcador', with: 'Apimentado'
    click_on 'Filtrar'

    expect(page).to have_content 'Resultado de pratos com a tag pesquisada'
    expect(page).to have_content 'Feijoada'
    expect(page).not_to have_content 'Arroz'
  end

  it 'e encontra pratos veganos' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    feijoada = Dish.create!(name: 'Feijoada', description: 'Descrição da feijoada', establishment: establishment)
    AdditionalFeature.create!(name: 'Apimentado', active: true, dish: feijoada)
    arroz = Dish.create!(name: 'Arroz', description: 'Descrição do arroz', establishment: establishment)
    AdditionalFeature.create!(name: 'Vegano', active: true, dish: arroz)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    fill_in 'Digite um Marcador', with: 'Vegano'
    click_on 'Filtrar'

    expect(page).to have_content 'Resultado de pratos com a tag pesquisada'
    expect(page).to have_content 'Arroz'
    expect(page).not_to have_content 'Feijoada'
  end
end
