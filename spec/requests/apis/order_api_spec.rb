require 'rails_helper'

describe 'Order API' do
  context 'GET /api/v1/establishments/:establishment_code/orders' do
    it 'Listar todos pedidos de um estabelecimento' do
      user_owner = UserOwner.create!(name: 'User', last_name: 'Owner', cpf: '59306160003',
                                            email: 'user@owner.com', password: 'password1234')
      allow(SecureRandom).to receive(:alphanumeric).with(6).and_return('CODE01')
      establishment = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA',
                                            cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18',
                                            telephone: '79977778888', email: 'fantasy@contato.com',
                                            user_owner: user_owner, opening_time: Time.parse('14:20'),
                                            closing_time: Time.parse('21:45'), code: 'COD123')
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ORDER001')
      Order.create!(customer_name: 'Primeiro Cliente', contact_phone: '79988887771',
                    contact_email: 'cliente1@email.com', establishment: establishment)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ORDER002')
      Order.create!(customer_name: 'Segundo Cliente', contact_phone: '79988887772',
                    contact_email: 'cliente2@email.com', establishment: establishment)

      get "/api/v1/establishments/CODE01/orders"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response[0]["customer_name"]).to eq 'Primeiro Cliente'
      expect(json_response[1]["customer_name"]).to eq 'Segundo Cliente'
    end

    it 'Listar todos pedidos com filtro de status "in_preparation"' do
      user_owner = create_user_owner
      allow(SecureRandom).to receive(:alphanumeric).with(6).and_return('CODE01')
      establishment = create_establishment(user_owner)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ORDER001')
      Order.create!(customer_name: 'Cliente 1', contact_phone: '79988887771', contact_email: 'cliente1@email.com',
      status: 'waiting_confirmation', establishment: establishment)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ORDER002')
      Order.create!(customer_name: 'Cliente 2', contact_phone: '79988887772', contact_email: 'cliente2@email.com',
      status: 'in_preparation', establishment: establishment)

      get "/api/v1/establishments/CODE01/orders?status=in_preparation"

      expect(response.status).to eq 200
      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq 1
      expect(json_response[0]['customer_name']).to eq 'Cliente 2'
    end

    it 'Listar todos pedidos de um estabelecimento que não existe' do
      get "/api/v1/establishments/999999/orders"

      expect(response.status).to eq 404
    end
  end

  context 'GET /api/v1/establishments/:establishment_code/orders/:order_code' do
    it 'Ver detalhes de um pedido' do
      user_owner = create_user_owner
      allow(SecureRandom).to receive(:alphanumeric).with(6).and_return('CODE01')
      establishment = create_establishment(user_owner)
      dish = Dish.create!(name: 'Feijoada', description: 'Feijão preto com carne', establishment: establishment)
      portion = Portion.create!(description: 'Feijoada M', price: '29.00', dish: dish)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ORDER001')
      order = Order.create!(customer_name: 'Cliente 1', contact_phone: '79988887771', contact_email: 'cliente1@email.com', status: 'waiting_confirmation', establishment: establishment)
      OrderItem.create!(quantity: 1, note: "Bem apimentado pfvr", order: order, dish: dish, portion: portion)

      get "/api/v1/establishments/CODE01/orders/ORDER001"

      expect(response.status).to eq 200
      json_response = JSON.parse(response.body)
      expect(json_response['customer_name']).to eq 'Cliente 1'
      expect(json_response['status']).to eq 'waiting_confirmation'
      expect(json_response['created_at']).to eq order.created_at.as_json
      order_items_details = json_response['order_items_details']
      expect(order_items_details.size).to eq 1
      expect(order_items_details[0]['dish_name']).to eq 'Feijoada'
      expect(order_items_details[0]['portion_name']).to eq 'Feijoada M'
      expect(order_items_details[0]['quantity']).to eq 1
      expect(order_items_details[0]['note']).to eq 'Bem apimentado pfvr'
    end

    it 'Ver detalhes de um pedido que não existe' do
      user_owner = create_user_owner
      allow(SecureRandom).to receive(:alphanumeric).with(6).and_return('CODE01')
      create_establishment(user_owner)

      get "/api/v1/establishments/CODE01/orders/ORDER001"

      expect(response.status).to eq 404
    end
  end

  context 'PATCH /api/v1/establishments/:establishment_code/orders/:order_code' do
    it 'Aceita um pedido: "waiting_confirmation" => "in_preparation"' do
      user_owner = create_user_owner
      allow(SecureRandom).to receive(:alphanumeric).with(6).and_return('CODE01')
      establishment = create_establishment(user_owner)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ORDER001')
      Order.create!(customer_name: 'Cliente 1', contact_phone: '79988887771', contact_email: 'cliente1@email.com',
      status: 'waiting_confirmation', establishment: establishment)

      patch "/api/v1/establishments/CODE01/orders/ORDER001"

      expect(response.status).to eq 200
      json_response = JSON.parse(response.body)
      expect(json_response['customer_name']).to eq 'Cliente 1'
      expect(json_response['status']).to eq 'in_preparation'
    end

    it 'Marca pedido como pronto: "in_preparation" => "ready"' do
      user_owner = create_user_owner
      allow(SecureRandom).to receive(:alphanumeric).with(6).and_return('CODE01')
      establishment = create_establishment(user_owner)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ORDER001')
      Order.create!(customer_name: 'Cliente 1', contact_phone: '79988887771', contact_email: 'cliente1@email.com',
      status: 'in_preparation', establishment: establishment)

      patch "/api/v1/establishments/CODE01/orders/ORDER001"

      expect(response.status).to eq 200
      json_response = JSON.parse(response.body)
      expect(json_response['customer_name']).to eq 'Cliente 1'
      expect(json_response['status']).to eq 'ready'
    end

    it 'Aceita um pedido: que não existe' do
      user_owner = create_user_owner
      allow(SecureRandom).to receive(:alphanumeric).with(6).and_return('CODE01')
      establishment = create_establishment(user_owner)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ORDER001')
      Order.create!(customer_name: 'Cliente 1', contact_phone: '79988887771', contact_email: 'cliente1@email.com',
      status: 'waiting_confirmation', establishment: establishment)

      patch "/api/v1/establishments/CODE01/orders/99999999"

      expect(response.status).to eq 404
    end
  end

  context 'PATCH /api/v1/establishments/:establishment_code/orders/:order_code/cancel' do
    it 'Cancela um pedido: "waiting_confirmation" => "cancelled"' do
      user_owner = create_user_owner
      allow(SecureRandom).to receive(:alphanumeric).with(6).and_return('CODE01')
      establishment = create_establishment(user_owner)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ORDER001')
      Order.create!(customer_name: 'Cliente 1', contact_phone: '79988887771', contact_email: 'cliente1@email.com',
      status: 'waiting_confirmation', establishment: establishment)

      patch "/api/v1/establishments/CODE01/orders/ORDER001/cancel", params: { reason: 'Cabô a cebola!' }

      expect(response.status).to eq 200
      json_response = JSON.parse(response.body)
      expect(json_response['customer_name']).to eq 'Cliente 1'
      expect(json_response['status']).to eq 'cancelled'
      expect(json_response['cancellation_reason']).to eq 'Cabô a cebola!'
    end

    it 'Cancela um pedido: "in_preparation" => "cancelled"' do
      user_owner = create_user_owner
      allow(SecureRandom).to receive(:alphanumeric).with(6).and_return('CODE01')
      establishment = create_establishment(user_owner)
      allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ORDER001')
      Order.create!(customer_name: 'Cliente 1', contact_phone: '79988887771', contact_email: 'cliente1@email.com',
      status: 'in_preparation', establishment: establishment)

      patch "/api/v1/establishments/CODE01/orders/ORDER001/cancel", params: { reason: 'Cabô a cebola!' }

      expect(response.status).to eq 200
      json_response = JSON.parse(response.body)
      expect(json_response['customer_name']).to eq 'Cliente 1'
      expect(json_response['status']).to eq 'cancelled'
      expect(json_response['cancellation_reason']).to eq 'Cabô a cebola!'
    end
  end
end
