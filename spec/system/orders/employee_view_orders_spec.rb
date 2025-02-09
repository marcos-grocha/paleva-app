require 'rails_helper'

describe 'Funcionário acessa rota de pedidos' do
  it 'sem estar logado' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    create_employee_pre_registration(user_owner, establishment)
    create_user_employee(user_owner, establishment)
    order = create_order(establishment)

    visit order_path(order)

    expect(current_path).to eq pa_leva_session_path
    expect(page).to have_content 'Acesso negado.'
  end

  it 'está logado mas não tem vínculo' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    create_employee_pre_registration(user_owner, establishment)
    create_user_employee(user_owner, establishment)
    order = create_order(establishment)
    user_owner_impostor = UserOwner.create!(name: 'User', last_name: 'Owner',
                                    cpf: CPF.generate, email: 'impostor@owner.com',
                                    password: 'password1234')
    establishment_impostor = Establishment.create!(fantasy_name: 'Impostor', corporate_name: 'Imp',
                                    cnpj: CNPJ.generate, address: 'Av Impostor, 1',
                                    telephone: '11977778888', email: 'impostor@estabelecimento.com',
                                    user_owner: user_owner, opening_time: Time.parse('12:00'),
                                    closing_time: Time.parse('15:00'))
    EmployeePreRegistration.create!(email: 'impostor@funcionario.com', cpf: '94952989038',
                                    user_owner: user_owner_impostor,
                                    establishment: establishment_impostor)
    user_employee_impostor = UserEmployee.create!(name: 'User', last_name: 'Employee',
                                    cpf: '94952989038', email: 'impostor@funcionario.com',
                                    password: 'password1234', user_owner: user_owner_impostor,
                                    establishment: establishment_impostor)

    login_as user_employee_impostor, scope: :user_employee
    visit order_path(order)

    expect(current_path).not_to eq order_path(order)
    expect(current_path).to eq menus_path
    expect(page).to have_content 'Você não possui acesso a este pedido.'
  end

  it 'e está logado' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    create_employee_pre_registration(user_owner, establishment)
    user_employee = create_user_employee(user_owner, establishment)
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

    login_as user_employee, scope: :user_employee
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
