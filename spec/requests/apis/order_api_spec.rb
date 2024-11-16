require 'rails_helper'

describe 'Order API' do
  context 'GET /api/v1/orders' do
    it 'busca todos os pedidos pelo código do estabelecimento' do
      user_owner = UserOwner.create!(
        name: 'User', last_name: 'Owner', cpf: '59306160003', email: 'user@owner.com', password: 'password1234'
        )
      establishment = Establishment.create!(
        fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45')
        )
      Order.create!(
        customer_name: 'Primeiro Cliente', contact_phone: '79988887771', contact_email: 'cliente1@email.com', establishment: establishment
        )
      Order.create!(
        customer_name: 'Segundo Cliente', contact_phone: '79988887772', contact_email: 'cliente2@email.com', establishment: establishment
        )
      
      get "/api/v1/orders/#{establishment.code}"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response[0]["customer_name"]).to eq 'Primeiro Cliente'
      expect(json_response[1]["customer_name"]).to eq 'Segundo Cliente'
    end

    it 'busca todos os pedidos por um código inexistente' do
      get "/api/v1/orders/999999"

      expect(response.status).to eq 404
    end
  end
end
