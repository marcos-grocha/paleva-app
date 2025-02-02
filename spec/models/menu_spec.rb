require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe 'É válido?' do
    it 'sucesso' do
      user_owner = UserOwner.create!(name: 'User', last_name: 'Owner', cpf: CPF.generate, email: 'user@owner.com', password: 'password1234')
      establishment = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'))
      menu = Menu.new(name: 'Menu', establishment: establishment)

      expect(menu.valid?).to eq true
    end

    context 'presença obrigatória:' do
      it 'falso quando nome está vazio' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        menu = Menu.new(name: '', establishment: establishment)

        expect(menu.valid?).to eq false
      end
    end

    context 'atributo único:' do
      it 'falso quando nome já foi cadastrado' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        Menu.create!(name: 'Menu', establishment: establishment)
        menu = Menu.new(name: 'Menu', establishment: establishment)

        expect(menu.valid?).to eq false
      end
    end

    context 'amarrações obrigatórias:' do
      it 'falso quando nome está vazio' do
        user_owner = create_user_owner
        create_establishment(user_owner)
        menu = Menu.new(name: 'Menu', establishment: nil)

        expect(menu.valid?).to eq false
      end
    end
  end
end
