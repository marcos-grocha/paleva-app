require 'rails_helper'

RSpec.describe AdditionalFeature, type: :model do
  describe 'É válido?' do
    it 'sucesso' do
      user_owner = UserOwner.create!(name: 'User', last_name: 'Owner', cpf: CPF.generate, email: 'user@owner.com', password: 'password1234')
      establishment = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'))
      dish = Dish.create!(name: 'Feijoada', description: 'Feijão preto com carne', establishment: establishment)
      additional_feature = AdditionalFeature.new(name: 'Acebolado', dish: dish)

      expect(additional_feature.valid?).to eq true
    end

    context 'presença obrigatória:' do
      it 'falso quando nome está vazio' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        dish = create_dish_arroz(establishment)
        additional_feature = AdditionalFeature.new(name: '', dish: dish)

        expect(additional_feature.valid?).to eq false
      end
    end

    context 'amarrações obrigatórias:' do
      it 'falso quando prato está vazio' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        create_dish_arroz(establishment)
        additional_feature = AdditionalFeature.new(name: 'Acebolado', dish: nil)

        expect(additional_feature.valid?).to eq false
      end
    end
  end
end
