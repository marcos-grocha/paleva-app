require 'rails_helper'

describe 'Usuário autenticado cadastra um menu' do
  it 'com sucesso' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    dish = create_dish(establishment)
    beverage = create_beverage(establishment)

    login_as user_owner
    visit root_path
    click_on 'Cardápio'
    click_on 'Cadastrar Cardápio'
    fill_in 'Nome', with: 'Primeiro Cardápio'
    check dish.name
    check beverage.name
    click_on 'Salvar'

    expect(page).to have_content 'Cardápio cadastrado com sucesso!'
    expect(page).to have_content 'Cardápios Disponíveis'
    expect(page).to have_content 'Primeiro Cardápio'
  end

  it 'com sucesso e vê detalhes' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    dish = create_dish(establishment)
    create_portion_dish(dish)
    beverage = create_beverage(establishment)
    create_portion_beverage(beverage)

    login_as user_owner
    visit root_path
    click_on 'Cardápio'
    click_on 'Cadastrar Cardápio'
    fill_in 'Nome', with: 'Primeiro Cardápio'
    check dish.name
    check beverage.name
    click_on 'Salvar'
    click_on 'Primeiro Cardápio'

    expect(page).to have_content 'Pratos Disponíveis'
    expect(page).to have_content dish.name
    expect(page).to have_content 'Bebidas Disponíveis'
    expect(page).to have_content beverage.name
    expect(page).to have_content 'R$ 99,00'
    expect(page).to have_content 'Descrição do support/auto_create.rb'
  end
end