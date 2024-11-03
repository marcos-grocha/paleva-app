require 'rails_helper'

describe 'Usuário clica em Pratos' do
  it 'vai em detalhes e desabilita um prato' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    prato = Dish.create!(name: 'Feijoada', description: 'Feijão preto com carne', establishment: establishment, status: true)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    click_on prato.name
    click_on 'Desativar'
    
    expect(page).to have_content 'Status do prato atualizado com sucesso.'
    expect(page).to have_content prato.name
    expect(page).to have_content prato.description
    expect(page).to have_content 'Desativado'
    expect(page).not_to have_content 'Ativado'
  end

  it 'vai em detalhes e habilita um prato' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    prato = Dish.create!(name: 'Feijoada', description: 'Feijão preto com carne', establishment: establishment, status: false)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    click_on prato.name
    click_on 'Ativar'

    expect(page).to have_content 'Status do prato atualizado com sucesso.'
    expect(page).to have_content prato.name
    expect(page).to have_content prato.description
    expect(page).to have_content 'Ativado'
    expect(page).not_to have_content 'Desativado'
  end
end