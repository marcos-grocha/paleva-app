require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'É válido?' do
    it 'sucesso' do
      user_owner = UserOwner.create!(name: 'User', last_name: 'Owner', cpf: CPF.generate, email: 'user@owner.com', password: 'password1234')
      establishment = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'))
      order = Order.new(customer_name: 'Cliente', contact_phone: '11977778888', contact_email: 'cliente@email.com', cpf: CPF.generate, establishment: establishment)

      expect(order.valid?).to eq true
    end

    context 'presença obrigatória:' do
      it 'falso quando nome do cliente está vazio' do # validates :customer_name, presence: true
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        order = Order.new(customer_name: '', contact_phone: '11977778888', contact_email: 'cliente@email.com', cpf: CPF.generate, establishment: establishment)

        expect(order.valid?).to eq false
      end
      
      it 'falso quando telefone e email estão vazios' do # validate :contact_validator
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        order = Order.new(customer_name: 'Cliente', contact_phone: '', contact_email: '', cpf: CPF.generate, establishment: establishment)

        expect(order.valid?).to eq false
      end
    end

    context 'atributo único:' do # before_validation :generate_code, on: :create
      it 'gera um código único e aleatório ao criar um estabelecimento' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        first_order = Order.create!(customer_name: 'First Cliente', contact_phone: '11977778888', contact_email: 'cliente@first.com', cpf: CPF.generate, establishment: establishment)
        second_order = Order.create!(customer_name: 'Second Cliente', contact_phone: '11977778888', contact_email: 'cliente@second.com', cpf: CPF.generate, establishment: establishment)

        expect(first_order.order_code).not_to be_empty
        expect(first_order.order_code.length).to eq 8
        expect(second_order.order_code).not_to be_empty
        expect(second_order.order_code.length).to eq 8
        expect(first_order.order_code).not_to eq second_order.order_code
      end
    end

    context 'atributo correto:' do
      # validate :cpf_validator, if: -> { cpf.present? }
      it 'falso quando cnpj não existe' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        order = Order.new(customer_name: 'Cliente', contact_phone: '11977778888', contact_email: 'cliente@email.com', cpf: '11111111111', establishment: establishment)

        expect(order.valid?).to eq false
      end
      # validates :contact_email, if: -> { email.present? }, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'inválido' }
      it 'falso quando email não existe' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        order = Order.new(customer_name: 'Cliente', contact_phone: '11977778888', contact_email: 'emaildifferent', cpf: CPF.generate, establishment: establishment)

        expect(order.valid?).to eq false
      end
      # validates :contact_phone, if: -> { telephone.present? }, length: { in: 10..11, message: 'deve conter 10 ou 11 dígitos' }
      it 'falso quando telefone é muito grande' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        order = Order.new(customer_name: 'Cliente', contact_phone: '119777788881', contact_email: 'cliente@email.com', cpf: CPF.generate, establishment: establishment)

        expect(order.valid?).to eq false
      end

      it 'falso quando telefone é muito pequeno' do
        user_owner = create_user_owner
        establishment = create_establishment(user_owner)
        order = Order.new(customer_name: 'Cliente', contact_phone: '119777788', contact_email: 'cliente@email.com', cpf: CPF.generate, establishment: establishment)

        expect(order.valid?).to eq false
      end
    end

    context 'amarrações obrigatórias:' do # belongs_to :establishment
      it 'falso quando estabelecimento está vazio' do
        user_owner = create_user_owner
        create_establishment(user_owner)
        order = Order.new(customer_name: 'Cliente', contact_phone: '11977778888', contact_email: 'cliente@email.com', cpf: CPF.generate, establishment: nil)

        expect(order.valid?).to eq false
      end
    end
  end
end
