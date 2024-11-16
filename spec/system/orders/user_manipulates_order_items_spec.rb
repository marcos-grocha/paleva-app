require 'rails_helper'

describe 'Usuário acessa os menus' do
  it 'e vê a lista de itens para um pedido vazia' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    dish = Dish.create!(name: 'Feijoada', description: 'Descrição da feijoada', establishment: establishment)
    Portion.create!(description: 'Porção de feijoada', price: '20.00', dish: dish)
    beverage = Beverage.create!(name: 'Refri', description: 'Descrição do refri', establishment: establishment)
    Portion.create!(description: 'Porção de refri', price: '10.00', beverage: beverage)
    menu = Menu.create!(name: 'Primeiro Cardápio', user_owner: user_owner)
    MenuDish.create!(menu: menu, dish: dish)
    MenuBeverage.create!(menu: menu, beverage: beverage)

    login_as user_owner
    visit root_path
    click_on 'Primeiro Cardápio'

    expect(page).to have_content 'Primeiro Cardápio'
    expect(page).to have_content 'Pedido Atual'
    expect(page).to have_content 'Nenhum item adicionado ao pedido.'
    expect(page).to have_content 'Pratos Disponíveis'
    expect(page).to have_content 'Feijoada'
    expect(page).to have_content 'Porção de feijoada: R$ 20,00'
    expect(page).to have_content 'Bebidas Disponíveis'
    expect(page).to have_content 'Refri'
    expect(page).to have_content 'Porção de refri: R$ 10,00'
    within "#dish_#{dish.id}" do
      within "#portion_#{dish.portions.first.id}" do
        expect(page).to have_button 'Adicionar ao Pedido'
      end
    end
  end

  it 'e adiciona itens ao pedido' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    dish = create_dish_feijoada(establishment)
    dish_portion = create_portion_dish(dish)
    beverage = create_beverage_refri(establishment)
    beverage_portion = create_portion_beverage(beverage)
    menu = Menu.create!(name: 'Primeiro Cardápio', user_owner: user_owner)
    MenuDish.create!(menu: menu, dish: dish)
    MenuBeverage.create!(menu: menu, beverage: beverage)
  
    login_as user_owner
    visit root_path
    click_on 'Primeiro Cardápio'
    within "#dish_#{dish.id}" do
      within "#portion_#{dish_portion.id}" do
        click_on 'Adicionar ao Pedido'
      end
    end
    within "#beverage_#{beverage.id}" do
      within "#portion_#{beverage_portion.id}" do
        click_on 'Adicionar ao Pedido'
      end
    end
  
    expect(page).to have_content 'Item adicionado ao pedido.'
    expect(page).to have_content 'Remover'
    expect(page).to have_content 'Finalizar Pedido'
    expect(page).not_to have_content 'Nenhum item adicionado ao pedido.'
  end

  it 'e remove itens ao pedido' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    dish = create_dish_feijoada(establishment)
    dish_portion = create_portion_dish(dish)
    menu = Menu.create!(name: 'Primeiro Cardápio', user_owner: user_owner)
    menu.dishes << dish

    login_as user_owner
    visit root_path
    click_on 'Primeiro Cardápio'
    within "#dish_#{dish.id}" do
      within "#portion_#{dish_portion.id}" do
        click_on 'Adicionar ao Pedido'
      end
    end
    click_on 'Remover'

    expect(page).to have_content 'Item removido do pedido.'
    expect(page).to have_content 'Nenhum item adicionado ao pedido.'
    expect(page).not_to have_content 'Remover'
    expect(page).not_to have_content 'Finalizar Pedido'
  end
end
