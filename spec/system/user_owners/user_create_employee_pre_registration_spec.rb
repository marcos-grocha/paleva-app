require 'rails_helper'

describe 'Usuário cria um pré cadastro para um funcionário' do
  it 'e não está logado' do
    user_owner = create_user_owner()
    create_establishment(user_owner)
    
    visit new_employee_pre_registration_path

    expect(current_path).to eq new_user_owner_session_path
  end

  it 'com sucesso' do
    user_owner = create_user_owner()
    create_establishment(user_owner)
    
    login_as user_owner
    visit root_path
    click_on 'Funcionários'
    click_on 'Cadastrar Funcionário'
    fill_in 'Email', with: 'usuario@funcionario.com'
    fill_in 'CPF', with: '59306160003'
    click_on 'Cadastrar'

    expect(page).to have_content 'Funcionário cadastrado com sucesso!'
    expect(page).to have_content 'Funcionários'
    expect(page).to have_content 'usuario@funcionario.com'
    expect(page).to have_content '59306160003'
    expect(page).to have_content 'Pendente'
    expect(current_path).to eq employee_pre_registrations_path
  end

  it 'com os dados errados' do
    user_owner = create_user_owner()
    create_establishment(user_owner)
    
    login_as user_owner
    visit root_path
    click_on 'Funcionários'
    click_on 'Cadastrar Funcionário'
    fill_in 'Email', with: 'usuariofuncionario'
    fill_in 'CPF', with: ''
    click_on 'Cadastrar'

    expect(page).to have_content 'Falha ao cadastrar funcionário!'
    expect(page).to have_content 'Verifique esse problemas:'
    expect(page).to have_content 'CPF não pode ficar em branco'
    expect(page).to have_content 'CPF inválido'
    expect(page).to have_content 'Email inválido'
  end
end

