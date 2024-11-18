require 'rails_helper'

RSpec.describe MenuDish, type: :model do
  describe 'É válido?' do
    it 'sucesso' do
      user_owner = UserOwner.create!(name: 'User', last_name: 'Owner', cpf: CPF.generate, email: 'user@owner.com', password: 'password1234')
      establishment = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'))
      dish = Dish.create!(name: 'Arroz', description: 'Branco', establishment: establishment)
      menu = Menu.create!(name: 'Menu', establishment: establishment)
      menu_dish = MenuDish.new(menu: menu, dish: dish)

      expect(menu_dish.valid?).to eq true
    end

    context 'amarrações obrigatórias:' do
      it 'falso quando menu está vazio' do # belongs_to :menu
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        dish = create_dish_arroz(establishment)
        Menu.create!(name: 'Menu', establishment: establishment)
        menu_dish = MenuDish.new(dish: dish, menu: nil)

        expect(menu_dish.valid?).to eq false
      end
      
      it 'falso quando dish está vazio' do # belongs_to :dish
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        create_dish_arroz(establishment)
        menu = Menu.create!(name: 'Menu', establishment: establishment)
        menu_dish = MenuDish.new(menu: menu, dish: nil)

        expect(menu_dish.valid?).to eq false
      end
    end
  end
end
