require 'rails_helper'

describe 'Usuário cria uma conta de funcionário' do
  it 'com sucesso' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    EmployeePreRegistration.create!(email: 'usuario@funcionario.com', cpf: '59306160003', user_owner: user_owner, establishment: establishment)

    visit root_path
    click_on 'Colaborador'
    click_on 'Cadastrar'
    fill_in 'Nome', with: 'Usuário'
    fill_in 'Sobrenome', with: 'Funcionário'
    fill_in 'CPF', with: '59306160003'
    fill_in 'E-mail', with: 'usuario@funcionario.com'
    fill_in 'Senha', with: 'password1234'
    fill_in 'Confirme sua senha', with: 'password1234'
    click_on 'Cadastrar'

    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'Usuário'
    expect(page).to have_content 'usuario@funcionario.com'
    user_employee = UserEmployee.last
    expect(user_employee.name).to eq 'Usuário'
  end

  it 'com os dados errados' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    EmployeePreRegistration.create!(email: 'usuario@funcionario.com', cpf: '59306160003', user_owner: user_owner, establishment: establishment)

    visit root_path
    click_on 'Colaborador'
    click_on 'Cadastrar'
    fill_in 'Nome', with: 'Usuário'
    fill_in 'Sobrenome', with: 'Funcionário'
    fill_in 'CPF', with: '64141431036'
    fill_in 'E-mail', with: 'email@errado.com'
    fill_in 'Senha', with: 'password1234'
    fill_in 'Confirme sua senha', with: 'password1234'
    click_on 'Cadastrar'

    expect(page).to have_content 'Não foi possível salvar funcionário'
    expect(page).to have_content 'Email e/ou CPF não disponível para cadastro'
    expect(page).not_to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
  end
end
