require 'rails_helper'

describe 'Funcionário faz login' do
  it 'com sucesso' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    EmployeePreRegistration.create!(email: 'usuario@funcionario.com', cpf: '59306160003', user_owner: user_owner, establishment: establishment)
    UserEmployee.create!(name: 'Usuário', last_name: 'Funcionário', cpf: '59306160003', email: 'usuario@funcionario.com', password: 'password1234')

    visit root_path
    click_on 'Funcionário'
    fill_in 'E-mail', with: 'usuario@funcionario.com'
    fill_in 'Senha', with: 'password1234'
    click_on 'Log in'
    
    expect(page).to have_content 'Login efetuado com sucesso.'
    expect(page).to have_button 'Sair'
  end

  it 'com os dados errados' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    EmployeePreRegistration.create!(email: 'usuario@funcionario.com', cpf: '59306160003', user_owner: user_owner, establishment: establishment)
    UserEmployee.create!(name: 'Usuário', last_name: 'Funcionário', cpf: '59306160003', email: 'usuario@funcionario.com', password: 'password1234')

    visit root_path
    click_on 'Funcionário'
    fill_in 'E-mail', with: 'email@errado.com'
    fill_in 'Senha', with: 'password5555'
    click_on 'Log in'
    
    expect(page).to have_content 'E-mail ou senha inválidos.'
    expect(page).not_to have_button 'Sair'
  end
end