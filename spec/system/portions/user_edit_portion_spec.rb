require 'rails_helper'

describe 'Usuário edita uma porção' do
  it 'através da página de detalhes de um prato' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    dish = create_dish(establishment)
    create_portion_dish(dish)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    click_on dish.name
    click_on 'Editar'
    fill_in 'Preço', with: 25.0
    click_on 'Atualizar Porção'

    expect(page).to have_content 'Porção atualizada com sucesso.'
    expect(page).to have_content dish.description
    expect(page).to have_content 'R$ 25,0'
    expect(page).not_to have_content 'R$ 99,0'
  end

  it 'através da página de detalhes de uma bebida' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    beverage = create_beverage(establishment)
    create_portion_beverage(beverage)

    login_as user_owner
    visit root_path
    click_on 'Bebidas'
    click_on beverage.name
    click_on 'Editar'
    fill_in 'Preço', with: 15.0
    click_on 'Atualizar Porção'

    expect(page).to have_content 'Porção atualizada com sucesso.'
    expect(page).to have_content beverage.description
    expect(page).to have_content 'R$ 15,0'
    expect(page).not_to have_content 'R$ 99,0'
  end
end