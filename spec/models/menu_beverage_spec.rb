require 'rails_helper'

RSpec.describe MenuBeverage, type: :model do
  describe 'É válido?' do
    it 'sucesso' do
      user_owner = UserOwner.create!(name: 'User', last_name: 'Owner', cpf: CPF.generate, email: 'user@owner.com', password: 'password1234')
      establishment = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'))
      beverage = Beverage.create!(name: 'Coca', description: 'Refri', establishment: establishment, alcoholic: false)
      menu = Menu.create!(name: 'Menu', establishment: establishment)
      menu_beverage = MenuBeverage.new(menu: menu, beverage: beverage)

      expect(menu_beverage.valid?).to eq true
    end

    context 'amarrações obrigatórias:' do
      it 'falso quando menu está vazio' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        beverage = create_beverage_cerveja(establishment)
        Menu.create!(name: 'Menu', establishment: establishment)
        menu_beverage = MenuBeverage.new(beverage: beverage, menu: nil)

        expect(menu_beverage.valid?).to eq false
      end

      it 'falso quando beverage está vazio' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        create_beverage_cerveja(establishment)
        menu = Menu.create!(name: 'Menu', establishment: establishment)
        menu_beverage = MenuBeverage.new(menu: menu, beverage: nil)

        expect(menu_beverage.valid?).to eq false
      end
    end
  end
end
