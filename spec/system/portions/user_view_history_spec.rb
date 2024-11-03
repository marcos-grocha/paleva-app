require 'rails_helper'

describe 'Usuário vê o histórico de uma porção' do
  it 'através da página de detalhes de um prato' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    dish = create_dish(establishment)
    portion = create_portion_dish(dish)
    portion.update!(price: 25.0)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    click_on dish.name
    click_on 'Histórico'

    expect(page).to have_content 'Detalhes da Porção'
    expect(page).to have_content 'Histórico de Alterações'
    expect(page).to have_content dish.description
    expect(page).to have_content 'R$ 25.0'
  end

  it 'através da página de detalhes de uma bebida' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    beverage = create_beverage(establishment)
    portion = create_portion_beverage(beverage)
    portion.update!(price: 15.0)

    login_as user_owner
    visit root_path
    click_on 'Bebidas'
    click_on beverage.name
    click_on 'Histórico'

    expect(page).to have_content 'Detalhes da Porção'
    expect(page).to have_content beverage.description
    expect(page).to have_content 'R$ 15.0'
  end
end