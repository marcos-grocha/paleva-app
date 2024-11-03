require 'rails_helper'

describe 'Usuário procura por um marcador' do
  it 'e encontra pratos apimentados' do
    user_owner = create_user
    establishment = create_establishment(user_owner)
    spicy_dish = create_dish(establishment)
    create_additional_features_spicy(spicy_dish)
    vegan_dish = create_second_dish(establishment)
    create_additional_features_vegan(vegan_dish)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    fill_in 'Digite um Marcador', with: 'Apimentado'
    click_on 'Filtrar'

    expect(page).to have_content 'Resultado de pratos com a tag pesquisada'
    expect(page).to have_content spicy_dish.name
    expect(page).not_to have_content vegan_dish.name
  end
  
  it 'e encontra pratos veganos' do
    user_owner = create_user
    establishment = create_establishment(user_owner)
    spicy_dish = create_dish(establishment)
    create_additional_features_spicy(spicy_dish)
    vegan_dish = create_second_dish(establishment)
    create_additional_features_vegan(vegan_dish)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    fill_in 'Digite um Marcador', with: 'Vegano'
    click_on 'Filtrar'

    expect(page).to have_content 'Resultado de pratos com a tag pesquisada'
    expect(page).to have_content vegan_dish.name
    expect(page).not_to have_content spicy_dish.name
  end
end