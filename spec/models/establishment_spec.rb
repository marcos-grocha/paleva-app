require 'rails_helper'

RSpec.describe Establishment, type: :model do
  describe 'É válido?' do
    it 'sucesso' do
      user_owner = UserOwner.create!(name: 'User', last_name: 'Owner', cpf: CPF.generate, email: 'user@owner.com', password: 'password1234')
      establishment = Establishment.new(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'))

      expect(establishment.valid?).to eq true
    end

    context 'presença obrigatória:' do # validates presence: true
      it 'falso quando nome fantasia está vazio' do #:fantasy_name,
        user_owner = create_user_owner
        establishment = Establishment.new(fantasy_name: '', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'))

        expect(establishment.valid?).to eq false
      end
      
      it 'falso quando nome corporativo está vazio' do # :corporate_name,
        user_owner = create_user_owner
        establishment = Establishment.new(fantasy_name: 'Fantasy', corporate_name: '', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'))

        expect(establishment.valid?).to eq false
      end
      
      it 'falso quando cnpj está vazio' do # :cnpj,
        user_owner = create_user_owner
        establishment = Establishment.new(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: '', address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'))

        expect(establishment.valid?).to eq false
      end
      
      it 'falso quando endereço está vazio' do # :address,
        user_owner = create_user_owner
        establishment = Establishment.new(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: '', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'))

        expect(establishment.valid?).to eq false
      end
      
      it 'falso quando telefone está vazio' do # :telephone,
        user_owner = create_user_owner
        establishment = Establishment.new(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'))

        expect(establishment.valid?).to eq false
      end
      
      it 'falso quando e-mail está vazio' do # :email,
        user_owner = create_user_owner
        establishment = Establishment.new(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: '', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'))

        expect(establishment.valid?).to eq false
      end
    end

    context 'atributo único:' do # validates :code, uniqueness: true, presence: true
      it 'gera um código único e aleatório ao criar um estabelecimento' do # :generate_code, on: :create
        first_owner = UserOwner.create!(
          name: 'First', last_name: 'Owner', cpf: CPF.generate, email: 'first@owner.com', password: 'password1234'
        )
        first_establishment = Establishment.create!(
          fantasy_name: 'First', corporate_name: 'First LTDA', cnpj: CNPJ.generate, address: 'Av First, 1', telephone: '11911112222', email: 'first@contato.com', user_owner: first_owner, opening_time: Time.parse('01:00'), closing_time: Time.parse('02:00')
        )
        second_owner = UserOwner.create!(
          name: 'Second', last_name: 'Owner', cpf: CPF.generate, email: 'second@owner.com', password: 'password1234'
        )
        second_establishment = Establishment.create!(
          fantasy_name: 'Second', corporate_name: 'Second LTDA', cnpj: CNPJ.generate, address: 'Av Second, 1', telephone: '11922223333', email: 'second@contato.com', user_owner: second_owner, opening_time: Time.parse('03:00'), closing_time: Time.parse('04:00')
        )

        expect(first_establishment.code).not_to be_empty
        expect(second_establishment.code).not_to be_empty
        expect(first_establishment.code.length).to eq 6
        expect(second_establishment.code.length).to eq 6
        expect(first_establishment.code).not_to eq second_establishment.code
      end

      it 'não altera o atributo único ao fazer updates' do
        user_owner = UserOwner.create!(name: 'User', last_name: 'Owner', cpf: CPF.generate, email: 'user@owner.com', password: 'password1234')
        establishment = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'))

        code_before_update = establishment.code
        establishment.update!(corporate_name: 'MC Donalds LTDA')

        expect(establishment.corporate_name).to eq 'MC Donalds LTDA'
        expect(establishment.code).to eq code_before_update
      end
    end

    context 'atributo correto:' do
      it 'falso quando cnpj não existe' do # validate :cnpj_validator
        user_owner = create_user_owner
        establishment = Establishment.new(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: '11111111111111', address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'))

        expect(establishment.valid?).to eq false
      end

      it 'falso quando email não existe' do # validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
        user_owner = UserOwner.create!(name: 'User', last_name: 'Owner', cpf: CPF.generate, email: 'user@owner.com', password: 'password1234')
        establishment = Establishment.new(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'emaildifferent', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'))

        expect(establishment.valid?).to eq false
      end

      it 'falso quando telefone é muito grande' do # validates :telephone length: deve conter 10 ou 11 dígitos / tem 12
        user_owner = UserOwner.create!(name: 'User', last_name: 'Owner', cpf: CPF.generate, email: 'user@owner.com', password: 'password1234')
        establishment = Establishment.new(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '119777788881', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'))
  
        expect(establishment.valid?).to eq false
      end

      it 'falso quando telefone é muito pequeno' do # validates :telephone length: deve conter 10 ou 11 dígitos / tem 9
        user_owner = UserOwner.create!(name: 'User', last_name: 'Owner', cpf: CPF.generate, email: 'user@owner.com', password: 'password1234')
        establishment = Establishment.new(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '117777888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'))
  
        expect(establishment.valid?).to eq false
      end
    end

    context 'amarrações obrigatórias:' do
      it 'falso quando dono de restaurante está vazio' do # belongs_to :user_owner
        create_user_owner
        establishment = Establishment.new(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'), user_owner: nil)

        expect(establishment.valid?).to eq false
      end
    end
  end
end
