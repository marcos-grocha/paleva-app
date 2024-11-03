require 'rails_helper'

describe 'Usuário registra uma porção' do
  it 'através da página de detalhes de um prato' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    dish = create_dish(establishment)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    click_on dish.name
    click_on 'Adicionar porção'
    fill_in 'Descrição', with: 'Porção pequena (350ml)'
    fill_in 'Preço', with: 18.00
    click_on 'Criar Porção'

    expect(page).to have_content 'Porção cadastrada com sucesso.'
    expect(page).to have_content 'Porção pequena (350ml)'
    expect(page).to have_content 'R$ 18,00'
  end

  it 'através da página de detalhes de uma bebida' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    beverage = create_beverage(establishment)

    login_as user_owner
    visit root_path
    click_on 'Bebidas'
    click_on beverage.name
    click_on 'Adicionar porção'
    fill_in 'Descrição', with: 'Longneck (355ml)'
    fill_in 'Preço', with: 15.00
    click_on 'Criar Porção'

    expect(page).to have_content 'Porção cadastrada com sucesso.'
    expect(page).to have_content 'Longneck (355ml)'
    expect(page).to have_content 'R$ 15,00'
  end
end