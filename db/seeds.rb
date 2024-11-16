# Apagando todos os dados
OrderItem.destroy_all
Order.destroy_all
MenuDish.destroy_all
MenuBeverage.destroy_all
Menu.destroy_all
PriceHistory.destroy_all
Portion.destroy_all
AdditionalFeature.destroy_all
Dish.destroy_all
Beverage.destroy_all
EmployeePreRegistration.destroy_all
UserEmployee.destroy_all
Establishment.destroy_all
UserOwner.destroy_all

# Cria 01 dono, 01 restaurante, 01 funcionário e 02 pré-cadastros
user_owner = UserOwner.create!(name: 'User', last_name: 'Owner', cpf: CPF.generate, email: 'user@owner.com', password: 'password1234')
establishment = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'), sunday: true, wednesday: true, thursday: true, friday: true, saturday: true)
EmployeePreRegistration.create!(email: 'out@employee.com', cpf: CPF.generate, user_owner: user_owner, establishment: establishment)
EmployeePreRegistration.create!(email: 'user@employee.com', cpf: '59306160003', user_owner: user_owner, establishment: establishment)
UserEmployee.create!(name: 'User', last_name: 'Employee', cpf: '59306160003', email: 'user@employee.com', password: 'password1234', user_owner: user_owner, establishment: establishment)

# 5 pratos
feijoada = Dish.create!(name: 'Feijoada', description: 'Feijão preto com carne', establishment: establishment)
AdditionalFeature.create!(name: 'Apimentado', active: true, dish: feijoada)
Portion.create!(description: 'Feijoada P', price: '19.00', dish: feijoada)
Portion.create!(description: 'Feijoada M', price: '29.00', dish: feijoada)
Portion.create!(description: 'Feijoada G', price: '39.00', dish: feijoada)

fritas = Dish.create!(name: 'Batata-Frita', description: 'Fritas em forma de tirinhas', establishment: establishment)
AdditionalFeature.create!(name: 'Tira-Gosto', active: true, dish: fritas)
Portion.create!(description: 'Batata P', price: '18.00', dish: fritas)
Portion.create!(description: 'Batata M', price: '28.00', dish: fritas)
Portion.create!(description: 'Batata G', price: '38.00', dish: fritas)

parmegiana = Dish.create!(name: 'Bife à Parmegiana', description: 'Bife empanado com molho de tomate e queijo', establishment: establishment)
AdditionalFeature.create!(name: 'Com Queijo Extra', active: true, dish: parmegiana)
Portion.create!(description: 'Bife P', price: '25.00', dish: parmegiana)
Portion.create!(description: 'Bife M', price: '35.00', dish: parmegiana)
Portion.create!(description: 'Bife G', price: '45.00', dish: parmegiana)

moqueca = Dish.create!(name: 'Moqueca de Peixe', description: 'Peixe cozido com leite de coco e temperos', establishment: establishment)
AdditionalFeature.create!(name: 'Acompanha Pirão', active: true, dish: moqueca)
Portion.create!(description: 'Moqueca P', price: '30.00', dish: moqueca)
Portion.create!(description: 'Moqueca M', price: '45.00', dish: moqueca)
Portion.create!(description: 'Moqueca G', price: '55.00', dish: moqueca)

bolonhesa = Dish.create!(name: 'Espaguete à Bolonhesa', description: 'Massa com molho de carne moída', establishment: establishment)
AdditionalFeature.create!(name: 'Com Parmesão', active: true, dish: bolonhesa)
Portion.create!(description: 'Espaguete P', price: '22.00', dish: bolonhesa)
Portion.create!(description: 'Espaguete M', price: '32.00', dish: bolonhesa)
Portion.create!(description: 'Espaguete G', price: '42.00', dish: bolonhesa)

# 5 bebidas
coca = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante de cola', establishment: establishment, alcoholic: false)
Portion.create!(description: 'Coca P', price: '10.00', beverage: coca)
Portion.create!(description: 'Coca M', price: '20.00', beverage: coca)
Portion.create!(description: 'Coca G', price: '30.00', beverage: coca)

heineken = Beverage.create!(name: 'Heineken', description: 'Cerveja puro-malte', establishment: establishment, alcoholic: true)
Portion.create!(description: 'Heineken P', price: '11.00', beverage: heineken)
Portion.create!(description: 'Heineken M', price: '21.00', beverage: heineken)
Portion.create!(description: 'Heineken G', price: '31.00', beverage: heineken)

suco_laranja = Beverage.create!(name: 'Suco de Laranja', description: 'Suco natural de laranja', establishment: establishment, alcoholic: false)
Portion.create!(description: 'Suco P', price: '8.00', beverage: suco_laranja)
Portion.create!(description: 'Suco M', price: '12.00', beverage: suco_laranja)
Portion.create!(description: 'Suco G', price: '16.00', beverage: suco_laranja)

agua_gas = Beverage.create!(name: 'Água com Gás', description: 'Água mineral gaseificada', establishment: establishment, alcoholic: false)
Portion.create!(description: 'Água P', price: '5.00', beverage: agua_gas)
Portion.create!(description: 'Água M', price: '8.00', beverage: agua_gas)
Portion.create!(description: 'Água G', price: '10.00', beverage: agua_gas)

caipirinha = Beverage.create!(name: 'Caipirinha', description: 'Bebida com limão, açúcar e cachaça', establishment: establishment, alcoholic: true)
Portion.create!(description: 'Caipirinha P', price: '15.00', beverage: caipirinha)
Portion.create!(description: 'Caipirinha M', price: '20.00', beverage: caipirinha)
Portion.create!(description: 'Caipirinha G', price: '25.00', beverage: caipirinha)

# 3 menus
cafe = Menu.create!(name: 'Café da manhã', establishment: establishment)
MenuDish.create!(menu: cafe, dish: fritas)
MenuDish.create!(menu: cafe, dish: bolonhesa)
MenuBeverage.create!(menu: cafe, beverage: suco_laranja)

almoco = Menu.create!(name: 'Almoço', establishment: establishment)
MenuDish.create!(menu: almoco, dish: feijoada)
MenuDish.create!(menu: almoco, dish: moqueca)
MenuBeverage.create!(menu: almoco, beverage: coca)
MenuBeverage.create!(menu: almoco, beverage: agua_gas)

janta = Menu.create!(name: 'Janta', establishment: establishment)
MenuDish.create!(menu: janta, dish: parmegiana)
MenuDish.create!(menu: janta, dish: feijoada)
MenuBeverage.create!(menu: janta, beverage: heineken)
MenuBeverage.create!(menu: janta, beverage: caipirinha)

puts 'O PaLevá do Marcos foi populado com sucesso!'