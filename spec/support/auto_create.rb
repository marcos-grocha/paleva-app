def create_user
  UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
end

def create_establishment(user_owner)
  Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('12:00'), closing_time: Time.parse('15:00'))
end

def create_dish(establishment)
  Dish.create!(name: 'Feijoada', description: 'Descrição do support/auto_create.rb', establishment: establishment)
end

def create_beverage(establishment)
  Beverage.create!(name: 'Coca-Cola', description: 'Descrição do support/auto_create.rb', establishment: establishment)
end

def create_portion_dish(dish)
  Portion.create!(description: 'Descrição do support/auto_create.rb', price: '99.00', dish: dish)
end

def create_portion_beverage(beverage)
  Portion.create!(description: 'Descrição do support/auto_create.rb', price: '99.00', beverage: beverage)
end
