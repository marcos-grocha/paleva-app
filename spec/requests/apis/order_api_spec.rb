require 'rails_helper'

describe 'Order API' do
  context 'GET /api/v1/orders' do
    it 'sucesso' do
      user_owner = create_user_owner()
      create_establishment(user_owner)
      Order.create!(customer_name: 'Cliente', contact_phone: '79988887777', contact_email: 'cliente@email.com', user_owner: user_owner)
      
      get "/api/v1/orders/"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response[0]["customer_name"]).to eq 'Cliente'
    end
  end
end
