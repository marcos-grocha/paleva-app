require 'rails_helper'

describe 'Usuário clica em Pratos' do
  it 'vai em detalhes e desabilita um prato' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    Dish.create!(name: 'Feijoada', description: 'Feijão preto com carne', establishment: establishment, status: true)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    click_on 'Feijoada'
    click_on 'Desativar'

    expect(page).to have_content 'Status do prato atualizado com sucesso.'
    expect(page).to have_content 'Feijoada'
    expect(page).to have_content 'Feijão preto com carne'
    expect(page).to have_content 'Desativado'
    expect(page).not_to have_content 'Ativo'
  end

  it 'vai em detalhes e habilita um prato' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    Dish.create!(name: 'Feijoada', description: 'Feijão preto com carne', establishment: establishment, status: false)

    login_as user_owner
    visit root_path
    click_on 'Pratos'
    click_on 'Feijoada'
    click_on 'Ativar'

    expect(page).to have_content 'Status do prato atualizado com sucesso.'
    expect(page).to have_content 'Feijoada'
    expect(page).to have_content 'Feijão preto com carne'
    expect(page).to have_content 'Ativo'
    expect(page).not_to have_content 'Desativado'
  end
end
