require 'rails_helper'

describe 'Usuário cadastra um pedido' do
  it 'e não está logado' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    create_dish_feijoada(establishment)
    create_beverage_refri(establishment)
    create_menu(user_owner)
    
    visit new_order_path

    expect(current_path).to eq pa_leva_session_path
  end

  it 'com sucesso' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    dish = Dish.create!(name: 'Feijoada', description: 'Descrição da feijoada', establishment: establishment)
    dish_portion = Portion.create!(description: 'Porção de feijoada', price: '20.00', dish: dish)
    beverage = Beverage.create!(name: 'Refri', description: 'Descrição do refri', establishment: establishment)
    beverage_portion = Portion.create!(description: 'Porção de refri', price: '10.00', beverage: beverage)
    menu = Menu.create!(name: 'Primeiro Cardápio', user_owner: user_owner)
    MenuDish.create!(menu: menu, dish: dish)
    MenuBeverage.create!(menu: menu, beverage: beverage)

    login_as user_owner
    visit root_path
    click_on 'Primeiro Cardápio'
    within "#dish_#{dish.id}" do
      within "#portion_#{dish_portion.id}" do
        fill_in 'Quantidade:', with: 2
        click_on 'Adicionar ao Pedido'
      end
    end
    within "#beverage_#{beverage.id}" do
      within "#portion_#{beverage_portion.id}" do
        fill_in 'Quantidade:', with: 1
        click_on 'Adicionar ao Pedido'
      end
    end
    click_on 'Finalizar Pedido'
    fill_in 'Nome do cliente', with: 'Cliente Marcos'
    fill_in 'Telefone', with: '79988887777'
    fill_in 'E-mail', with: 'cliente@email.com'
    fill_in 'CPF', with: CPF.generate
    click_on 'Salvar'

    expect(page).to have_content 'Pedido realizado com sucesso'
    expect(page).to have_content Order.last.order_code
    expect(page).not_to have_content 'Nenhum pedido disponível'
    expect(current_path).to eq orders_path
  end

  it 'com sucesso e vê detalhes' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    dish = Dish.create!(name: 'Feijoada', description: 'Descrição da feijoada', establishment: establishment)
    dish_portion = Portion.create!(description: 'Porção de feijoada', price: '20.00', dish: dish)
    beverage = Beverage.create!(name: 'Refri', description: 'Descrição do refri', establishment: establishment)
    beverage_portion = Portion.create!(description: 'Porção de refri', price: '10.00', beverage: beverage)
    menu = Menu.create!(name: 'Primeiro Cardápio', user_owner: user_owner)
    MenuDish.create!(menu: menu, dish: dish)
    MenuBeverage.create!(menu: menu, beverage: beverage)

    login_as user_owner
    visit root_path
    click_on 'Primeiro Cardápio'
    within "#dish_#{dish.id}" do
      within "#portion_#{dish_portion.id}" do
        fill_in 'Quantidade:', with: 2
        click_on 'Adicionar ao Pedido'
      end
    end
    within "#beverage_#{beverage.id}" do
      within "#portion_#{beverage_portion.id}" do
        fill_in 'Quantidade:', with: 3
        click_on 'Adicionar ao Pedido'
      end
    end
    click_on 'Finalizar Pedido'
    fill_in 'Nome do cliente', with: 'Cliente Marcos'
    fill_in 'Telefone', with: '79988887777'
    fill_in 'E-mail', with: 'cliente@email.com'
    fill_in 'CPF', with: CPF.generate
    click_on 'Salvar'
    click_on Order.last.order_code

    expect(page).to have_content Order.last.order_code
    expect(page).to have_content 'Cliente Marcos'
    expect(page).to have_content 'Feijoada'
    expect(page).to have_content 'Porção de feijoada'
    expect(page).to have_content '20.0'
    expect(page).to have_content 'Refri'
    expect(page).to have_content 'Porção de refri'
    expect(page).to have_content '10.0'
    expect(page).to have_content 'Valor total do pedido: R$ 70.0'
    expect(page).to have_content 'Status: Aguardando confirmação'
  end

  it 'com os dados errados' do
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
    click_on 'Finalizar Pedido'
    fill_in 'Nome do cliente', with: 'Cliente Marcos'
    fill_in 'Telefone', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'CPF', with: CPF.generate
    click_on 'Salvar'

    expect(page).to have_content 'Falha ao realizar pedido'
    expect(page).to have_content 'Verifique esse problemas:'
    expect(page).to have_content '- Informe pelo menos um telefone ou e-mail de contato.'
  end
end