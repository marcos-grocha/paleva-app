require 'rails_helper'

describe 'Usuário acessa detalhes de uma bebida' do
  it 'e edita os dados' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    beverage = create_beverage(establishment)

    login_as user_owner
    visit root_path
    click_on 'Bebidas'
    click_on beverage.name
    click_on 'editar'
    fill_in 'Descrição', with: 'Teste: Editei a descrição'
    click_on 'Salvar'

    expect(page).to have_content 'Bebida atualizado com sucesso.'
    expect(page).to have_content beverage.name
    expect(page).to have_content 'Teste: Editei a descrição'
    expect(page).not_to have_content 'Descrição do support/auto_create.rb'
  end

  it 'e não está autenticado' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    beverage = create_beverage(establishment)

    visit edit_beverage_path(beverage)
    
    expect(current_path).to eq new_user_owner_session_path
  end

  it 'e não tem autorização pra editar' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    beverage = create_beverage(establishment)
    user_impostor = UserOwner.create!(name: 'Impostor', last_name: 'Zé', cpf: CPF.generate, email: 'impostor@email.com', password: 'password1234')

    login_as user_impostor
    visit edit_beverage_path(beverage)

    expect(current_path).to eq new_establishment_path
    expect(page).to have_content 'Você não possui acesso a esta bebida.'
  end
end
