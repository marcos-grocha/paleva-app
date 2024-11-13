require 'rails_helper'

describe 'Funcionário visita a rota raiz' do
  it 'e não está logado' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    EmployeePreRegistration.create!(email: 'usuario@funcionario.com', cpf: '59306160003', user_owner: user_owner, establishment: establishment)
    UserEmployee.create!(name: 'User', last_name: 'Employee', cpf: '59306160003', email: 'usuario@funcionario.com', password: 'password1234', user_owner: user_owner, establishment: establishment)
    
    visit root_path

    expect(current_path).to eq pa_leva_session_path
  end

  it 'e está logado' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    EmployeePreRegistration.create!(email: 'usuario@funcionario.com', cpf: '59306160003', user_owner: user_owner, establishment: establishment)
    UserEmployee.create!(name: 'User', last_name: 'Employee', cpf: '59306160003', email: 'usuario@funcionario.com', password: 'password1234', user_owner: user_owner, establishment: establishment)

    visit root_path
    click_on 'Funcionário'
    fill_in 'E-mail', with: 'usuario@funcionario.com'
    fill_in 'Senha', with: 'password1234'
    click_on 'Log in'

    expect(current_path).to eq menus_path
  end
end