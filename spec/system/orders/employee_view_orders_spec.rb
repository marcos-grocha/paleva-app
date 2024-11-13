require 'rails_helper'

describe 'Funcionário vê pedidos' do
  it 'com sucesso' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    create_employee_pre_registration(user_owner, establishment)
    user_employee = create_user_employee(user_owner, establishment)

    login_as user_employee, scope: :user_employee
    visit root_path
    click_on 'Pedidos'

    expect(page).to have_content 'Nenhum pedido disponível'
  end
end