require 'rails_helper'

RSpec.describe UserOwner, type: :model do
  describe 'É Válido?' do
    it 'sucesso' do
      user_owner = UserOwner.new(name: 'User', last_name: 'Owner', cpf: CPF.generate, email: 'user@owner.com', password: 'password1234')

      expect(user_owner.valid?).to eq true
    end

    context 'presença obrigatória:' do
      it 'falso quando nome está vazio' do
        user_owner = UserOwner.new(name: '', last_name: 'Owner', cpf: CPF.generate, email: 'user@owner.com', password: 'password1234')

        expect(user_owner.valid?).to eq false
      end

      it 'falso quando sobrenome está vazio' do
        user_owner = UserOwner.new(name: 'User', last_name: '', cpf: CPF.generate, email: 'user@owner.com', password: 'password1234')

        expect(user_owner.valid?).to eq false
      end

      it 'falso quando cpf está vazio' do
        user_owner = UserOwner.new(name: 'User', last_name: 'Owner', cpf: '', email: 'user@owner.com', password: 'password1234')

        expect(user_owner.valid?).to eq false
      end
    end

    context 'atributo único:' do
      it 'falso quando cpf já foi cadastrado' do
        UserOwner.create!(name: 'First', last_name: 'Owner', cpf: '19304525004', email: 'user@owner.com', password: 'password1234')
        user_owner = UserOwner.new(name: 'Second', last_name: 'Owner', cpf: '19304525004', email: 'user@owner.com', password: 'password1234')

        expect(user_owner.valid?).to eq false
      end
    end

    context 'atributo correto:' do
      it 'falso quando cpf não existe' do
        user_owner = UserOwner.new(name: 'User', last_name: 'Owner', cpf: '11111111111', email: 'user@owner.com', password: 'password1234')

        expect(user_owner.valid?).to eq false
      end
    end
  end
end
