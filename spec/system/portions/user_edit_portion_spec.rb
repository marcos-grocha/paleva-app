require 'rails_helper'

describe 'Usuário edita uma porção' do
  it 'através da página de detalhes de um prato' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    dish = Dish.create!(name: 'Feijoada', description: 'Descrição da feijoada', establishment: establishment)
    Portion.create!(description: 'Descrição da porção', price: '99.00', dish: dish)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    click_on 'Feijoada'
    click_on 'Editar'
    fill_in 'Preço', with: 25.0
    click_on 'Atualizar Porção'

    expect(page).to have_content 'Porção atualizada com sucesso.'
    expect(page).to have_content 'Descrição da porção'
    expect(page).to have_content 'R$ 25,0'
    expect(page).not_to have_content 'R$ 99,0'
  end

  it 'através da página de detalhes de uma bebida' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    beverage = Beverage.create!(name: 'Refri', description: 'Descrição do refri', establishment: establishment)
    Portion.create!(description: 'Descrição da porção', price: '99.00', beverage: beverage)

    login_as user_owner
    visit root_path
    click_on 'Bebidas'
    click_on 'Refri'
    click_on 'Editar'
    fill_in 'Preço', with: 15.0
    click_on 'Atualizar Porção'

    expect(page).to have_content 'Porção atualizada com sucesso.'
    expect(page).to have_content 'Descrição da porção'
    expect(page).to have_content 'R$ 15,0'
    expect(page).not_to have_content 'R$ 99,0'
  end
end