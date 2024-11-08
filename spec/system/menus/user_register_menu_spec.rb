require 'rails_helper'

describe 'Usuário cadastra um menu' do
  it 'e não está logado' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    create_dish_feijoada(establishment)
    create_beverage_refri(establishment)
    
    visit new_menu_path

    expect(current_path).to eq new_user_owner_session_path
  end

  it 'com sucesso' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    Dish.create!(name: 'Feijoada', description: 'Descrição da feijoada', establishment: establishment)
    Beverage.create!(name: 'Refri', description: 'Descrição do refri', establishment: establishment)

    login_as user_owner
    visit root_path
    click_on 'Cadastrar Cardápio'
    fill_in 'Nome', with: 'Primeiro Cardápio'
    check 'Feijoada'
    check 'Refri'
    click_on 'Salvar'

    expect(page).to have_content 'Cardápio cadastrado com sucesso!'
    expect(page).to have_content 'Cardápios Disponíveis'
    expect(page).to have_content 'Primeiro Cardápio'
  end

  it 'com sucesso e vê detalhes' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    dish = Dish.create!(name: 'Feijoada', description: 'Descrição da feijoada', establishment: establishment)
    Portion.create!(description: 'Porção de feijoada', price: '99.00', dish: dish)
    beverage = Beverage.create!(name: 'Refri', description: 'Descrição do refri', establishment: establishment)
    Portion.create!(description: 'Porção de refri', price: '88.00', beverage: beverage)

    login_as user_owner
    visit root_path
    click_on 'Cadastrar Cardápio'
    fill_in 'Nome', with: 'Primeiro Cardápio'
    check 'Feijoada'
    check 'Refri'
    click_on 'Salvar'
    click_on 'Primeiro Cardápio'

    expect(page).to have_content 'Pratos Disponíveis'
    expect(page).to have_content 'Feijoada'
    expect(page).to have_content 'Porção de feijoada'
    expect(page).to have_content 'R$ 99,00'
    expect(page).to have_content 'Bebidas Disponíveis'
    expect(page).to have_content 'Refri'
    expect(page).to have_content 'Porção de refri'
    expect(page).to have_content 'R$ 88,00'
  end

  it 'com os dados errados' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    Dish.create!(name: 'Feijoada', description: 'Descrição da feijoada', establishment: establishment)
    Beverage.create!(name: 'Refri', description: 'Descrição do refri', establishment: establishment)

    login_as user_owner
    visit root_path
    click_on 'Cadastrar Cardápio'
    fill_in 'Nome', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Não foi possível cadastrar o cardápio.'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).not_to have_content 'Cardápio cadastrado com sucesso!'
  end
end