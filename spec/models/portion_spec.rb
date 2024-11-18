require 'rails_helper'

RSpec.describe Portion, type: :model do
 describe 'É válido?' do
    it 'sucesso' do
      user_owner = UserOwner.create!(name: 'User', last_name: 'Owner', cpf: CPF.generate, email: 'user@owner.com', password: 'password1234')
      establishment = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'))
      dish = Dish.create!(name: 'Feijoada', description: 'Feijão preto com carne', establishment: establishment)
      portion = Portion.new(description: 'Copo 500ml', price: '30.00', dish: dish)
      
      expect(portion.valid?).to eq true
    end

    context 'presença obrigatória:' do
      it 'falso quando descrição está vazio' do # validates :description, presence: true
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        dish = create_dish_arroz(establishment)
        portion = Portion.new(description: '', price: '30.00', dish: dish)

        expect(portion.valid?).to eq false
      end
      
      it 'falso quando preço está vazio' do # validates :price, presence: true
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        dish = create_dish_arroz(establishment)
        portion = Portion.new(description: 'Copo 500ml', price: '', dish: dish)

        expect(portion.valid?).to eq false
      end
    end
  end
end
