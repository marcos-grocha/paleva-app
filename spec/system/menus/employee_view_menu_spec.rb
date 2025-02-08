require 'rails_helper'

describe 'Funcionário acessa rota de cardápios' do
  it 'sem estar logado' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    menu = create_menu(establishment)
    create_employee_pre_registration(user_owner, establishment)
    create_user_employee(user_owner, establishment)

    visit menu_path(menu)

    expect(current_path).to eq pa_leva_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'está logado mas não tem vínculo' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    menu = create_menu(establishment)
    create_employee_pre_registration(user_owner, establishment)
    create_user_employee(user_owner, establishment)
    user_owner_impostor = UserOwner.create!(name: 'User', last_name: 'Owner',
                                    cpf: CPF.generate, email: 'impostor@owner.com',
                                    password: 'password1234')
    establishment_impostor = Establishment.create!(fantasy_name: 'Impostor', corporate_name: 'Imp',
                                    cnpj: CNPJ.generate, address: 'Av Impostor, 1',
                                    telephone: '11977778888', email: 'impostor@estabelecimento.com',
                                    user_owner: user_owner, opening_time: Time.parse('12:00'),
                                    closing_time: Time.parse('15:00'))
    EmployeePreRegistration.create!(email: 'impostor@funcionario.com', cpf: '94952989038',
                                    user_owner: user_owner_impostor,
                                    establishment: establishment_impostor)
    user_employee_impostor = UserEmployee.create!(name: 'User', last_name: 'Employee',
                                    cpf: '94952989038', email: 'impostor@funcionario.com',
                                    password: 'password1234', user_owner: user_owner_impostor,
                                    establishment: establishment_impostor)

    login_as user_employee_impostor, scope: :user_employee
    visit menu_path(menu)

    expect(current_path).not_to eq menu_path(menu)
    expect(current_path).to eq menus_path
    expect(page).to have_content 'Você não possui acesso a este menu.'
  end

  it 'e está logado' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    menu = create_menu(establishment)
    create_employee_pre_registration(user_owner, establishment)
    user_employee = create_user_employee(user_owner, establishment)

    login_as user_employee, scope: :user_employee
    visit menu_path(menu)

    expect(current_path).to eq menu_path(menu)
  end
end
