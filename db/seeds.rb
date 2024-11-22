require "open-uri"

puts '...Apagando todos os dados...'
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

ENV['SEED_MODE'] = 'true'

puts 'Criando 01 administrador, 01 restaurante, 01 colaborador e 02 pré-cadastros...'
user_owner = UserOwner.create!(name: 'User', last_name: 'Owner', cpf: CPF.generate, email: 'user@owner.com', password: 'password1234')
establishment = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('04:20'), closing_time: Time.parse('17:45'), monday: true, tuesday: true, wednesday: true, thursday: true, friday: true, saturday: true)
EmployeePreRegistration.create!(email: 'out@employee.com', cpf: CPF.generate, user_owner: user_owner, establishment: establishment)
EmployeePreRegistration.create!(email: 'user@employee.com', cpf: '59306160003', user_owner: user_owner, establishment: establishment)
UserEmployee.create!(name: 'User', last_name: 'Employee', cpf: '59306160003', email: 'user@employee.com', password: 'password1234', user_owner: user_owner, establishment: establishment)

ENV.delete('SEED_MODE')

puts 'Criando 5 pratos...'
sleep(5)
feijoada = Dish.create!(name: 'Feijoada', description: 'Feijão preto com carne', establishment: establishment, calories: 54)
AdditionalFeature.create!(name: 'Apimentado', active: true, dish: feijoada)
Portion.create!(description: 'Feijoada P', price: '19.00', dish: feijoada)
Portion.create!(description: 'Feijoada M', price: '29.00', dish: feijoada)
Portion.create!(description: 'Feijoada G', price: '39.00', dish: feijoada)

fritas = Dish.create!(name: 'Batata-Frita', description: 'Fritas em forma de tirinhas', establishment: establishment, calories: 61)
AdditionalFeature.create!(name: 'Tira-Gosto', active: true, dish: fritas)
Portion.create!(description: 'Batata P', price: '18.00', dish: fritas)
Portion.create!(description: 'Batata M', price: '28.00', dish: fritas)
Portion.create!(description: 'Batata G', price: '38.00', dish: fritas)

parmegiana = Dish.create!(name: 'Bife à Parmegiana', description: 'Bife empanado com molho de tomate e queijo', establishment: establishment, calories: 57)
AdditionalFeature.create!(name: 'Com Queijo Extra', active: true, dish: parmegiana)
Portion.create!(description: 'Bife P', price: '25.00', dish: parmegiana)
Portion.create!(description: 'Bife M', price: '35.00', dish: parmegiana)
Portion.create!(description: 'Bife G', price: '45.00', dish: parmegiana)

moqueca = Dish.create!(name: 'Moqueca de Peixe', description: 'Peixe cozido com leite de coco e temperos', establishment: establishment, calories: 44)
AdditionalFeature.create!(name: 'Acompanha Pirão', active: true, dish: moqueca)
Portion.create!(description: 'Moqueca P', price: '30.00', dish: moqueca)
Portion.create!(description: 'Moqueca M', price: '45.00', dish: moqueca)
Portion.create!(description: 'Moqueca G', price: '55.00', dish: moqueca)

bolonhesa = Dish.create!(name: 'Espaguete à Bolonhesa', description: 'Massa com molho de carne moída', establishment: establishment, calories: 36)
AdditionalFeature.create!(name: 'Com Parmesão', active: true, dish: bolonhesa)
Portion.create!(description: 'Espaguete P', price: '22.00', dish: bolonhesa)
Portion.create!(description: 'Espaguete M', price: '32.00', dish: bolonhesa)
Portion.create!(description: 'Espaguete G', price: '42.00', dish: bolonhesa)

puts 'Criando 5 bebidas...'
sleep(5)
coca = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante de cola', establishment: establishment, alcoholic: false, calories: 0)
Portion.create!(description: 'Coca P', price: '10.00', beverage: coca)
Portion.create!(description: 'Coca M', price: '20.00', beverage: coca)
Portion.create!(description: 'Coca G', price: '30.00', beverage: coca)

heineken = Beverage.create!(name: 'Heineken', description: 'Cerveja puro-malte', establishment: establishment, alcoholic: true, calories: 2)
Portion.create!(description: 'Heineken P', price: '11.00', beverage: heineken)
Portion.create!(description: 'Heineken M', price: '21.00', beverage: heineken)
Portion.create!(description: 'Heineken G', price: '31.00', beverage: heineken)

suco_laranja = Beverage.create!(name: 'Suco de Laranja', description: 'Suco natural de laranja', establishment: establishment, alcoholic: false, calories: 18)
Portion.create!(description: 'Suco P', price: '8.00', beverage: suco_laranja)
Portion.create!(description: 'Suco M', price: '12.00', beverage: suco_laranja)
Portion.create!(description: 'Suco G', price: '16.00', beverage: suco_laranja)

agua_gas = Beverage.create!(name: 'Água com Gás', description: 'Água mineral gaseificada', establishment: establishment, alcoholic: false, calories: 3)
Portion.create!(description: 'Água P', price: '5.00', beverage: agua_gas)
Portion.create!(description: 'Água M', price: '8.00', beverage: agua_gas)
Portion.create!(description: 'Água G', price: '10.00', beverage: agua_gas)

caipirinha = Beverage.create!(name: 'Caipirinha', description: 'Bebida com limão, açúcar e cachaça', establishment: establishment, alcoholic: true, calories: 17)
Portion.create!(description: 'Caipirinha P', price: '15.00', beverage: caipirinha)
Portion.create!(description: 'Caipirinha M', price: '20.00', beverage: caipirinha)
Portion.create!(description: 'Caipirinha G', price: '25.00', beverage: caipirinha)

puts 'Anexando as fotos dos pratos... (Levará cerca de 30 segundos)'
sleep(5)
file = URI.open(Rails.root.join("app/assets/images/items/feijoada.jpg"))
feijoada.photo.attach(io: File.open(file), filename: "feijoada.jpg", content_type: "image/jpeg")
sleep(5)
file = URI.open(Rails.root.join("app/assets/images/items/fritas.jpg"))
fritas.photo.attach(io: File.open(file), filename: "fritas.jpg", content_type: "image/jpeg")
sleep(5)
file = URI.open(Rails.root.join("app/assets/images/items/parmegiana.jpg"))
parmegiana.photo.attach(io: File.open(file), filename: "parmegiana.jpg", content_type: "image/jpeg")
sleep(5)
file = URI.open(Rails.root.join("app/assets/images/items/moqueca.jpg"))
moqueca.photo.attach(io: File.open(file), filename: "moqueca.jpg", content_type: "image/jpeg")
sleep(5)
file = URI.open(Rails.root.join("app/assets/images/items/bolonhesa.jpg"))
bolonhesa.photo.attach(io: File.open(file), filename: "bolonhesa.jpg", content_type: "image/jpeg")

puts 'Anexando as fotos das bebidas... (Levará cerca de 30 segundos)'
sleep(5)
file = URI.open(Rails.root.join("app/assets/images/items/coca.jpg"))
coca.photo.attach(io: File.open(file), filename: "coca.jpg", content_type: "image/jpeg")
sleep(5)
file = URI.open(Rails.root.join("app/assets/images/items/heineken.jpg"))
heineken.photo.attach(io: File.open(file), filename: "heineken.jpg", content_type: "image/jpeg")
sleep(5)
file = URI.open(Rails.root.join("app/assets/images/items/suco-laranja.png"))
suco_laranja.photo.attach(io: File.open(file), filename: "suco-laranja.png", content_type: "image/jpeg")
sleep(5)
file = URI.open(Rails.root.join("app/assets/images/items/agua-com-gas.jpg"))
agua_gas.photo.attach(io: File.open(file), filename: "agua-com-gas.jpg", content_type: "image/jpeg")
sleep(5)
file = URI.open(Rails.root.join("app/assets/images/items/caipirinha.png"))
caipirinha.photo.attach(io: File.open(file), filename: "caipirinha.jpg", content_type: "image/jpeg")

puts 'Criando 3 menus...'
sleep(5)
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

puts 'Criando 6 pedidos...'
sleep(5)
order1 = Order.create!(customer_name: 'João Campus', contact_phone: '11999998888', contact_email: 'joao.campus@campuscode.com', cpf: CPF.generate, establishment: establishment)
OrderItem.create!(quantity: 2, note: 'Sem pimenta', order: order1, portion: feijoada.portions.find_by(description: 'Feijoada M'), dish: feijoada)
OrderItem.create!(quantity: 1, note: '', order: order1, portion: coca.portions.find_by(description: 'Coca G'), beverage: coca)

order2 = Order.create!(customer_name: 'Helena Oliveira', contact_phone: '21999997777', contact_email: 'helena.oliveira@email.com', cpf: CPF.generate, establishment: establishment)
OrderItem.create!(quantity: 1, note: 'Extra queijo', order: order2, portion: parmegiana.portions.find_by(description: 'Bife G'), dish: parmegiana)
OrderItem.create!(quantity: 2, note: '', order: order2, portion: agua_gas.portions.find_by(description: 'Água P'), beverage: agua_gas)

order3 = Order.create!(customer_name: 'Matheus Silva', contact_phone: '31988886666', contact_email: 'matheus.silva@email.com', cpf: CPF.generate, establishment: establishment)
OrderItem.create!(quantity: 3, note: '', order: order3, portion: fritas.portions.find_by(description: 'Batata M'), dish: fritas)
OrderItem.create!(quantity: 1, note: 'Com menos gelo', order: order3, portion: caipirinha.portions.find_by(description: 'Caipirinha M'), beverage: caipirinha)

order4 = Order.create!(customer_name: 'Leticia Amado', contact_phone: '42977775555', contact_email: 'leticiaamadoaa@email.com', cpf: CPF.generate, establishment: establishment)
OrderItem.create!(quantity: 1, note: 'Sem pirão', order: order4, portion: moqueca.portions.find_by(description: 'Moqueca P'), dish: moqueca)
OrderItem.create!(quantity: 2, note: '', order: order4, portion: suco_laranja.portions.find_by(description: 'Suco G'), beverage: suco_laranja)

order5 = Order.create!(customer_name: 'Marcos Guimarães', contact_phone: '51966664444', contact_email: 'marcos.grocha@campuscode.com', cpf: CPF.generate, establishment: establishment)
OrderItem.create!(quantity: 1, note: '', order: order5, portion: bolonhesa.portions.find_by(description: 'Espaguete G'), dish: bolonhesa)
OrderItem.create!(quantity: 2, note: '', order: order5, portion: heineken.portions.find_by(description: 'Heineken G'), beverage: heineken)

order6 = Order.create!(customer_name: 'Patrícia Lima', contact_phone: '61955553333', contact_email: 'patricia.lima@email.com', cpf: CPF.generate, establishment: establishment)
OrderItem.create!(quantity: 2, note: '', order: order6, portion: feijoada.portions.find_by(description: 'Feijoada G'), dish: feijoada)
OrderItem.create!(quantity: 1, note: '', order: order6, portion: agua_gas.portions.find_by(description: 'Água M'), beverage: agua_gas)

# Cria outro administrador que tem um estabelecimento que funciona de madrugada
user2_owner = UserOwner.create!(name: 'User2', last_name: 'Owner', cpf: CPF.generate, email: 'user2@owner.com', password: 'password1234')
Establishment.create!(fantasy_name: 'Madrugão', corporate_name: 'Mag LTDA', cnpj: CNPJ.generate, address: 'Av Galegos, 1', telephone: '79933338888', email: 'madrugao@contato.com', user_owner: user2_owner, opening_time: Time.parse('17:46'), closing_time: Time.parse('04:19'), sunday: true, wednesday: true, thursday: true, friday: true, saturday: true)

# Cria outro menu que está desativado
sazonal = Menu.create!(name: 'Cardápio Sazonal', establishment: establishment, status: false)
MenuDish.create!(menu: sazonal, dish: parmegiana)
MenuBeverage.create!(menu: sazonal, beverage: heineken)

puts 'OK! O PaLevá do Marcos foi populado com sucesso!'