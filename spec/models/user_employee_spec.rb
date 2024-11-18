require 'rails_helper'

RSpec.describe UserEmployee, type: :model do
  describe 'É Válido?' do
    it 'sucesso' do
      user_owner = create_user_owner
      establishment = create_establishment(user_owner)
      EmployeePreRegistration.create!(email: 'user@employee.com', cpf: '59306160003', user_owner: user_owner, establishment: establishment)
      user_employee = UserEmployee.new(name: 'User', last_name: 'Employee', cpf: '59306160003', email: 'user@employee.com', password: 'password1234', user_owner: user_owner, establishment: establishment)

      expect(user_employee.valid?).to eq true
    end

    context 'pré-requisito:' do # before_validation :check_pre_registration
      it 'falso quando pré-cadastro não existe' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        user_employee = UserEmployee.new(name: 'User', last_name: 'Employee', cpf: '59306160003', email: 'user@employee.com', password: 'password1234', user_owner: user_owner, establishment: establishment)

        expect(user_employee.valid?).to eq false
      end

      it 'falso quando pré-cadastro existe mas o email é diferente' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        EmployeePreRegistration.create!(email: 'user@different.com', cpf: '59306160003', user_owner: user_owner, establishment: establishment)
        user_employee = UserEmployee.new(name: 'User', last_name: 'Employee', cpf: '59306160003', email: 'user@employee.com', password: 'password1234', user_owner: user_owner, establishment: establishment)

        expect(user_employee.valid?).to eq false
      end

      it 'falso quando pré-cadastro existe mas o cpf é diferente' do # validate :cpf_validator
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        EmployeePreRegistration.create!(email: 'user@employee.com', cpf: '19304525004', user_owner: user_owner, establishment: establishment)
        user_employee = UserEmployee.new(name: 'User', last_name: 'Employee', cpf: '59306160003', email: 'user@employee.com', password: 'password1234', user_owner: user_owner, establishment: establishment)

        expect(user_employee.valid?).to eq false
      end
    end
    
    context 'presença obrigatória:' do # validates :name, :last_name, :cpf, presence: true
      it 'falso quando nome está vazio' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        EmployeePreRegistration.create!(email: 'user@employee.com', cpf: '59306160003', user_owner: user_owner, establishment: establishment)
        user_employee = UserEmployee.new(name: '', last_name: 'Employee', cpf: '59306160003', email: 'user@employee.com', password: 'password1234', user_owner: user_owner, establishment: establishment)

        expect(user_employee.valid?).to eq false
      end
      
      it 'falso quando sobrenome está vazio' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        EmployeePreRegistration.create!(email: 'user@employee.com', cpf: '59306160003', user_owner: user_owner, establishment: establishment)
        user_employee = UserEmployee.new(name: 'User', last_name: '', cpf: '59306160003', email: 'user@employee.com', password: 'password1234', user_owner: user_owner, establishment: establishment)

        expect(user_employee.valid?).to eq false
      end
      
      it 'falso quando cpf está vazio' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        EmployeePreRegistration.create!(email: 'user@employee.com', cpf: '59306160003', user_owner: user_owner, establishment: establishment)
        user_employee = UserEmployee.new(name: 'User', last_name: 'Employee', cpf: '', email: 'user@employee.com', password: 'password1234', user_owner: user_owner, establishment: establishment)

        expect(user_employee.valid?).to eq false
      end
    end

    context 'atributo único:' do # validates :cpf, uniqueness: true
      it 'falso quando cpf já foi cadastrado' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        EmployeePreRegistration.create!(email: 'user@employee.com', cpf: '59306160003', user_owner: user_owner, establishment: establishment)
        UserEmployee.create!(name: 'First', last_name: 'Employee', cpf: '59306160003', email: 'user@employee.com', password: 'password1234', user_owner: user_owner, establishment: establishment)
        user_employee = UserEmployee.new(name: 'Second', last_name: 'Employee', cpf: '59306160003', email: 'user@employee.com', password: 'password1234', user_owner: user_owner, establishment: establishment)
  
        expect(user_employee.valid?).to eq false
      end
    end
  end
end
