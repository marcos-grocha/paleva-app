require 'rails_helper'

describe 'Dono acessa rota de pedidos' do
  it 'sem estar logado' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    order = create_order(establishment)

    visit order_path(order)

    expect(current_path).to eq pa_leva_session_path
    expect(page).to have_content 'Acesso negado.'
  end

  it 'está logado mas não tem vínculo' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    order = create_order(establishment)
    user_impostor = UserOwner.create!(name: 'Impostor', last_name: 'Zé', cpf: CPF.generate, email: 'impostor@email.com', password: 'password1234')

    login_as user_impostor
    visit order_path(order)

    expect(current_path).not_to eq order_path(order)
    expect(current_path).to eq new_establishment_path
    expect(page).to have_content 'Você não possui acesso a este pedido.'
  end

  it 'e está logado' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    dish = Dish.create!(name: 'Feijoada', description: 'Descrição da feijoada', establishment: establishment)
    dish_portion = Portion.create!(description: 'Porção de feijoada', price: '20.00', dish: dish)
    beverage = Beverage.create!(name: 'Refri', description: 'Descrição do refri', establishment: establishment)
    beverage_portion = Portion.create!(description: 'Porção de refri', price: '10.00', beverage: beverage)
    menu = Menu.create!(name: 'Primeiro Cardápio', establishment: establishment)
    MenuDish.create!(menu: menu, dish: dish)
    MenuBeverage.create!(menu: menu, beverage: beverage)
    order = Order.create!(customer_name: 'Marcos', contact_phone: '11977778888', contact_email: 'cliente@email.com', cpf: CPF.generate, establishment: establishment)
    OrderItem.create!(quantity: 1, note: "Sem pimenta", order: order, portion: dish_portion, dish: dish)
    OrderItem.create!(quantity: 1, note: "Sem açucar", order: order, portion: beverage_portion, beverage: beverage)

    login_as user_owner
    visit order_path(order)

    expect(page).to have_content 'Detalhes do Pedido # '
    expect(page).to have_content 'Marcos'
    expect(page).to have_content 'Feijoada'
    expect(page).to have_content 'Porção de feijoada'
    expect(page).to have_content 'Sem pimenta'
    expect(page).to have_content 'Refri'
    expect(page).to have_content 'Porção de refri'
    expect(page).to have_content 'Sem açucar'
    expect(current_path).to eq order_path(order)
  end
end
