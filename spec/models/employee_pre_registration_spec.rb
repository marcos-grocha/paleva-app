require 'rails_helper'

RSpec.describe EmployeePreRegistration, type: :model do
  describe 'É Válido?' do
    it 'sucesso' do
      user_owner = create_user_owner
      establishment = create_establishment(user_owner)
      pre_registration = EmployeePreRegistration.new(email: 'user@employee.com', cpf: '59306160003', user_owner: user_owner, establishment: establishment)

      expect(pre_registration.valid?).to eq true
    end

    context 'presença obrigatória:' do
      it 'falso quando email está vazio' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        pre_registration = EmployeePreRegistration.new(email: '', cpf: '59306160003', user_owner: user_owner, establishment: establishment)

        expect(pre_registration.valid?).to eq false
      end

      it 'falso quando cpf está vazio' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        pre_registration = EmployeePreRegistration.new(email: 'user@employee.com', cpf: '', user_owner: user_owner, establishment: establishment)

        expect(pre_registration.valid?).to eq false
      end
    end

    context 'atributo único:' do
      it 'falso quando email já foi cadastrado' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        EmployeePreRegistration.create!(email: 'user@employee.com', cpf: '59306160003', user_owner: user_owner, establishment: establishment)
        pre_registration = EmployeePreRegistration.new(email: 'user@employee.com', cpf: '19304525004', user_owner: user_owner, establishment: establishment)

        expect(pre_registration.valid?).to eq false
      end

      it 'falso quando cpf já foi cadastrado' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        EmployeePreRegistration.create!(email: 'user@employee.com', cpf: '59306160003', user_owner: user_owner, establishment: establishment)
        pre_registration = EmployeePreRegistration.new(email: 'user@different.com', cpf: '59306160003', user_owner: user_owner, establishment: establishment)

        expect(pre_registration.valid?).to eq false
      end
    end

    context 'atributo correto:' do
      it 'falso quando cpf não existe' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        pre_registration = EmployeePreRegistration.new(email: 'user@employee.com', cpf: '11111111111', user_owner: user_owner, establishment: establishment)

        expect(pre_registration.valid?).to eq false
      end

      it 'falso quando email não existe' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        pre_registration = EmployeePreRegistration.new(email: 'emaildifferent', cpf: '59306160003', user_owner: user_owner, establishment: establishment)

        expect(pre_registration.valid?).to eq false
      end
    end

    context 'amarrações obrigatórias:' do
      it 'falso quando dono de restaurante está vazio' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        pre_registration = EmployeePreRegistration.new(email: 'user@employee.com', cpf: '59306160003', establishment: establishment, user_owner: nil)

        expect(pre_registration.valid?).to eq false
      end

      it 'falso quando restaurante está vazio' do
        user_owner = create_user_owner
        create_establishment(user_owner)
        pre_registration = EmployeePreRegistration.new(email: 'user@employee.com', cpf: '59306160003', user_owner: user_owner, establishment: nil)

        expect(pre_registration.valid?).to eq false
      end
    end
  end
end
