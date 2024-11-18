def create_user_owner
  UserOwner.create!(name: 'User', last_name: 'Owner', cpf: CPF.generate, email: 'user@owner.com', password: 'password1234')
end

def create_employee_pre_registration(user_owner, establishment)
  EmployeePreRegistration.create!(email: 'user@employee.com', cpf: '59306160003', user_owner: user_owner, establishment: establishment)
end

def create_user_employee(user_owner, establishment)
  UserEmployee.create!(name: 'User', last_name: 'Employee', cpf: '59306160003', email: 'user@employee.com', password: 'password1234', user_owner: user_owner, establishment: establishment)
end

def create_establishment(user_owner)
  Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'))
end

def create_dish_feijoada(establishment)
  Dish.create!(name: 'Feijoada', description: 'Descrição do support/auto_create.rb', establishment: establishment)
end

def create_dish_arroz(establishment)
  Dish.create!(name: 'Arroz', description: 'Descrição do support/auto_create.rb', establishment: establishment)
end

def create_beverage_refri(establishment)
  Beverage.create!(name: 'Refri', description: 'Descrição do support/auto_create.rb', establishment: establishment, alcoholic: false)
end

def create_beverage_cerveja(establishment)
  Beverage.create!(name: 'Cerveja', description: 'Descrição do support/auto_create.rb', establishment: establishment, alcoholic: true)
end

def create_portion_dish(dish)
  Portion.create!(description: 'Descrição do support/auto_create.rb', price: '99.00', dish: dish)
end

def create_portion_beverage(beverage)
  Portion.create!(description: 'Descrição do support/auto_create.rb', price: '99.00', beverage: beverage)
end

def create_additional_features_spicy(dish)
  AdditionalFeature.create!(name: 'Apimentado', active: true, dish: dish)
end

def create_additional_features_vegan(dish)
  AdditionalFeature.create!(name: 'Vegano', active: true, dish: dish)
end

def create_menu(establishment)
  Menu.create!(name: 'Menu', establishment: establishment)
end

def association_menu_dish(menu, dish)
  MenuDish.create!(menu: menu, dish: dish)
end

def association_menu_beverage(menu, beverage)
  MenuBeverage.create!(menu: menu, beverage: beverage)
end

def create_order(establishment)
  Order.create!(customer_name: 'Cliente', contact_phone: '11977778888', contact_email: 'cliente@email.com', cpf: CPF.generate, establishment: establishment)
end

def create_order_item(order, portion)
  OrderItem.create!(quantity: 1, note: "Sem cebola", order: order, portion: portion)
end

def create_price_history(portion)
  PriceHistory.create!(portion: portion)
end
