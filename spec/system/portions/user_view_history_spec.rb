require 'rails_helper'

describe 'Usuário vê o histórico de uma porção' do
  it 'através da página de detalhes de um prato' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    dish = Dish.create!(name: 'Feijoada', description: 'Descrição da feijoada', establishment: establishment)
    portion = Portion.create!(description: 'Descrição da porção', price: '99.00', dish: dish)
    portion.update!(price: 25.0)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    click_on 'Feijoada'
    click_on 'Histórico'

    expect(page).to have_content 'Detalhes da Porção'
    expect(page).to have_content 'Histórico de Alterações'
    expect(page).to have_content 'Descrição da porção'
    expect(page).to have_content 'R$ 25.0'
  end

  it 'através da página de detalhes de uma bebida' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    beverage = Beverage.create!(name: 'Refri', description: 'Descrição do refri', establishment: establishment)
    portion = Portion.create!(description: 'Descrição da porção', price: '99.00', beverage: beverage)
    portion.update!(price: 15.0)

    login_as user_owner
    visit root_path
    click_on 'Bebidas'
    click_on 'Refri'
    click_on 'Histórico'

    expect(page).to have_content 'Detalhes da Porção'
    expect(page).to have_content 'Histórico de Alterações'
    expect(page).to have_content 'Descrição da porção'
    expect(page).to have_content 'R$ 15.0'
  end
end