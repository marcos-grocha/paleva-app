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
end
