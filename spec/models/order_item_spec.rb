require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'É válido?' do
    it 'sucesso' do
      user_owner = UserOwner.create!(name: 'User', last_name: 'Owner', cpf: CPF.generate, email: 'user@owner.com', password: 'password1234')
      establishment = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'))
      dish = Dish.create!(name: 'Feijoada', description: 'Feijão preto com carne', establishment: establishment)
      order = Order.create!(customer_name: 'Cliente', contact_phone: '11977778888', contact_email: 'cliente@email.com', cpf: CPF.generate, establishment: establishment)
      portion = Portion.new(description: 'Copo 500ml', price: '30.00', dish: dish)
      order_item = OrderItem.new(quantity: 1, note: "Sem cebola", order: order, portion: portion)

      expect(order_item.valid?).to eq true
    end

    context 'presença obrigatória:' do
      it 'falso quando quantidade está vazio' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        dish = create_dish_arroz(establishment)
        order = create_order(establishment)
        portion = create_portion_dish(dish)
        order_item = OrderItem.new(quantity: nil, note: "Sem cebola", order: order, portion: portion)

        expect(order_item.valid?).to eq false
      end
    end

    context 'atributo correto:' do
      it 'falso quando quantidade é menor que 1' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        dish = create_dish_arroz(establishment)
        order = create_order(establishment)
        portion = create_portion_dish(dish)
        order_item = OrderItem.new(quantity: 0, note: "Sem cebola", order: order, portion: portion)

        expect(order_item.valid?).to eq false
      end
    end

    context 'amarrações obrigatórias:' do
      it 'falso quando pedido está vazio' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        dish = create_dish_arroz(establishment)
        create_order(establishment)
        portion = create_portion_dish(dish)
        order_item = OrderItem.new(quantity: 1, note: "Sem cebola", portion: portion, order: nil)

        expect(order_item.valid?).to eq false
      end

      it 'falso quando porção está vazio' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        dish = create_dish_arroz(establishment)
        order = create_order(establishment)
        create_portion_dish(dish)
        order_item = OrderItem.new(quantity: 1, note: "Sem cebola", order: order, portion: nil)

        expect(order_item.valid?).to eq false
      end
    end
  end
end
