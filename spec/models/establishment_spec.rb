require 'rails_helper'

RSpec.describe Establishment, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe '#valid?' do
    context 'casos específicos' do
      it 'false when cnpj is invalid (less)' do
        establishment = Establishment.new(fantasy_name: 'Fantasy', corporate_name: 'Corporate LTDA', cnpj: '12345', address: 'Av das flores, 100', telephone: '79988887777', email: 'teste@email.com')
        result = establishment.valid?
        expect(result).to eq false
      end
      
      it 'false when cnpj is invalid (more)' do
        establishment = Establishment.new(fantasy_name: 'Fantasy', corporate_name: 'Corporate LTDA', cnpj: '123451234512345', address: 'Av das flores, 100', telephone: '79988887777', email: 'teste@email.com')
        result = establishment.valid?
        expect(result).to eq false
      end

      it 'false when telephone is invalid (less)' do
        establishment = Establishment.new(fantasy_name: 'Fantasy', corporate_name: 'Corporate LTDA', cnpj: CNPJ.generate, address: 'Av das flores, 100', telephone: '988887777', email: 'teste@email.com')
        result = establishment.valid?
        expect(result).to eq false
      end

      it 'false when telephone is invalid (more)' do
        establishment = Establishment.new(fantasy_name: 'Fantasy', corporate_name: 'Corporate LTDA', cnpj: CNPJ.generate, address: 'Av das flores, 100', telephone: '799888877770', email: 'teste@email.com')
        result = establishment.valid?
        expect(result).to eq false
      end

      it 'false when email is invalid' do
        establishment = Establishment.new(fantasy_name: 'Fantasy', corporate_name: 'Corporate LTDA', cnpj: CNPJ.generate, address: 'Av das flores, 100', telephone: '79988887777', email: 'testeemail')
        result = establishment.valid?
        expect(result).to eq false
      end
      
      it 'false when code is invalid' do
        # TO-DO
      end
    end

    context 'presence' do
      it 'false when fantasy_name is empty' do
        establishment = Establishment.new(fantasy_name: '', corporate_name: 'Corporate LTDA', cnpj: CNPJ.generate, address: 'Av das flores, 100', telephone: '79988887777', email: 'teste@email.com')
        result = establishment.valid?
        expect(result).to eq false
      end
      
      it 'false when corporate_name is empty' do
        establishment = Establishment.new(fantasy_name: 'Fantasy', corporate_name: '', cnpj: CNPJ.generate, address: 'Av das flores, 100', telephone: '79988887777', email: 'teste@email.com')
        result = establishment.valid?
        expect(result).to eq false
      end
      
      it 'false when cnpj is empty' do
        establishment = Establishment.new(fantasy_name: 'Fantasy', corporate_name: 'Corporate LTDA', cnpj: '', address: 'Av das flores, 100', telephone: '79988887777', email: 'teste@email.com')
        result = establishment.valid?
        expect(result).to eq false
      end
      
      it 'false when address is empty' do
        establishment = Establishment.new(fantasy_name: 'Fantasy', corporate_name: 'Corporate LTDA', cnpj: CNPJ.generate, address: '', telephone: '79988887777', email: 'teste@email.com')
        result = establishment.valid?
        expect(result).to eq false
      end
      
      it 'false when telephone is empty' do
        establishment = Establishment.new(fantasy_name: 'Fantasy', corporate_name: 'Corporate LTDA', cnpj: CNPJ.generate, address: 'Av das flores, 100', telephone: '', email: 'teste@email.com')
        result = establishment.valid?
        expect(result).to eq false
      end
      
      it 'false when email is empty' do
        establishment = Establishment.new(fantasy_name: 'Fantasy', corporate_name: 'Corporate LTDA', cnpj: CNPJ.generate, address: 'Av das flores, 100', telephone: '79988887777', email: '')
        result = establishment.valid?
        expect(result).to eq false
      end
    end
  end

  describe 'gera um código único e aleatório' do
    it 'ao criar um estabelecimento' do
    u1 = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
    u2 = UserOwner.create!(name: 'João', last_name: 'Campus', cpf: CPF.generate, email: 'joao@email.com', password: 'password5678')
    e1 = Establishment.new(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: u1, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
    e2 = Establishment.create!(fantasy_name: 'MC Donalds', corporate_name: 'Mc LTDA', cnpj: CNPJ.generate, address: 'Av Campus Code, 29', telephone: '79911112222', email: 'donalds@contato.com', user_owner: u2, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))

    e1.save!

    expect(e1.code).not_to be_empty
    expect(e1.code.length).to eq 6
    expect(e1.code).not_to eq e2.code
    end

    it 'e não deve ser modificado' do 
      u = UserOwner.create!(name: 'Marcos', last_name: 'Guimarães', cpf: CPF.generate, email: 'marcos@email.com', password: 'password1234')
      e = Establishment.create!(fantasy_name: 'MC Donalds', corporate_name: 'Mc LTDA', cnpj: CNPJ.generate, address: 'Av Campus Code, 33', telephone: '79911112222', email: 'donalds@contato.com', user_owner: u, opening_time: Time.parse('09:00'), closing_time: Time.parse('15:00'))
      e_current_code = e.code

      e.update!(corporate_name: 'MC Donalds LTDA')

      expect(e.code).to eq e_current_code
    end
  end
end
