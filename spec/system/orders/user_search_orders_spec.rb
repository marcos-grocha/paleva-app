require 'rails_helper'

describe 'Usuário busca um pedido' do
  it 'com sucesso' do
    user_owner = create_user_owner
    establishment = Establishment.create!(fantasy_name: 'Fantasy', corporate_name: 'Irã LTDA', cnpj: CNPJ.generate, address: 'Av Dulce Diniz, 18', telephone: '79977778888', email: 'fantasy@contato.com', user_owner: user_owner, opening_time: Time.parse('14:20'), closing_time: Time.parse('21:45'))
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODE1234')
    Order.create!(customer_name: 'Marcos', contact_phone: '11977778888', contact_email: 'cliente@email.com', cpf: CPF.generate, establishment: establishment)

    visit root_path
    click_on 'Rastrear pedido ativo'
    fill_in 'Código do pedido', with: 'CODE1234'
    click_on 'Procurar'

    expect(page).to have_content 'Busque por um pedido ativo'
    expect(page).to have_content 'Pedido # CODE1234'
    expect(page).to have_content 'Marcos'
    expect(page).to have_content 'Aguardando confirmação'
    expect(page).to have_content 'Contatos do Fantasy'
    expect(page).to have_content 'Av Dulce Diniz, 18'
    expect(page).to have_content '79977778888'
    expect(page).to have_content 'fantasy@contato.com'
  end

  it 'que não existe' do
    visit root_path
    click_on 'Rastrear pedido ativo'
    fill_in 'Código do pedido', with: 'CODEERRADO'
    click_on 'Procurar'

    expect(page).to have_content 'Busque por um pedido ativo'
    expect(page).to have_content 'Nenhum pedido encontrado com o código informado.'
  end
end
