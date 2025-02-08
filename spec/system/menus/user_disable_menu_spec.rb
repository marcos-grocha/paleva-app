require 'rails_helper'

describe 'Usuário clica em Cardápios' do
  it 'vai em detalhes e desabilita um cardápio' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    Menu.create!(name: 'Primeiro Cardápio', establishment: establishment, status: true)

    login_as user_owner
    visit root_path
    click_on 'Cardápios'
    click_on 'Primeiro Cardápio'
    click_on 'Desativar'

    expect(page).to have_content 'Status do cardápio atualizado com sucesso.'
    expect(page).to have_content 'Primeiro Cardápio'
    expect(page).to have_content 'Ativar'
    expect(page).not_to have_content 'Desativar'
  end

  it 'vai em detalhes e habilita um cardápio' do
    user_owner = create_user_owner()
    establishment = create_establishment(user_owner)
    Menu.create!(name: 'Primeiro Cardápio', establishment: establishment, status: false)

    login_as user_owner
    visit root_path
    click_on 'Cardápios'
    click_on 'Primeiro Cardápio'
    click_on 'Ativar'

    expect(page).to have_content 'Status do cardápio atualizado com sucesso.'
    expect(page).to have_content 'Primeiro Cardápio'
    expect(page).to have_content 'Desativar'
    expect(page).not_to have_content 'Ativo'
  end
end
