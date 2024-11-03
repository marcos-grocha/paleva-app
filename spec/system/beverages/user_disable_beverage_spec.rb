require 'rails_helper'

describe 'Usuário clica em Bebidas' do
  it 'vai em detalhes e desabilita uma bebida' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    bebida = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante de cola', establishment: establishment)

    login_as user_owner
    visit root_path
    click_on 'Bebidas'
    click_on bebida.name
    click_on 'Desativar'
    
    expect(page).to have_content 'Status da bebida atualizado com sucesso.'
    expect(page).to have_content bebida.name
    expect(page).to have_content bebida.description
    expect(page).to have_content 'Desativado'
    expect(page).not_to have_content 'Ativado'
  end
  
  it 'vai em detalhes e habilita uma bebida' do
    user_owner = create_user()
    establishment = create_establishment(user_owner)
    bebida = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante de cola', establishment: establishment, status: false)

    login_as user_owner
    visit root_path
    click_on 'Bebidas'
    click_on bebida.name
    click_on 'Ativar'

    expect(page).to have_content 'Status da bebida atualizado com sucesso.'
    expect(page).to have_content bebida.name
    expect(page).to have_content bebida.description
    expect(page).to have_content 'Ativado'
    expect(page).not_to have_content 'Desativado'
  end
end
